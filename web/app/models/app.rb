class App < ActiveRecord::Base
  attr_accessible #none

  belongs_to :key

  after_save :set_aid

  # TODO (uncomment) validates_uniqueness_of :title, scope: [:platform, :version]

  auto_strip :title

  @queue = :main #:apps

  def progress(status, state="", proper=true)
    self.status, self.state, self.proper = status, state, proper ; save
  end

  def rating
    # TODO combine vtrating, +/- rating, etc.
    self.vtrating || 0.0
  end

  def user
    key.user
  end

  def handle_upload(file, key)
    progress(10, "Extracting metadata")
    # TODO this is bad -- but file past in gets deleted after the response
    base = rand(36 ** 8).to_s(36)
    tmp = File.new(File.join(Rails.root, "tmp/uploads/#{base}"), "wb")
    tmp.write(file.read)
    fpath = File.absolute_path(tmp)
    # TODO don't close it yet (we need it for async method, don't like this
    # solution though...
    # TODO content_type is not good enough
    case file.content_type
    when "application/vnd.android.package-archive"
      Resque.enqueue(App, self.id, :handle_apk, fpath: fpath, key_id: key.id)
    else
      progress(100, "Unrecognized filetype", false)
      return false
    end
    true
  end

  def handle_apk(opts={})
    fpath, key_id = opts["fpath"], opts["key_id"]
    # TODO
    # unzip
    # cat META-INF/CERT.RSA | keytool -printcert
    # check with key
    Dir.mktmpdir do |tmpdir|
      apkout = `apktool d -f #{fpath} #{tmpdir}`
      Dir.chdir(tmpdir) do
        File.open("AndroidManifest.xml", "r") do |manifest|
          doc = Nokogiri::XML(manifest)
          # TODO if value starts with @, need to check res/ for actual value
          self.version = doc.xpath("/manifest/@android:versionName")[0].value
          self.title = doc.xpath("/manifest/application/@android:label")[0].value
          self.scrapeid = doc.xpath("/manifest/@package")[0].value
          self.platform = :android
          progress(40)
          raise "Duplicate version upload for #{title}" unless valid?
        end
      end
    end
    self.scan(fpath)
  rescue Exception => e
    progress(100, e.message, false)
  ensure
    # TODO delete the temp file now
    File.unlink(fpath)
  end

  def scan(fpath, force=false)
    return if self.vtpermalink and !force
    progress(70, "Virus Total: Sending binary")
    url = "https://www.virustotal.com/vtapi/v2/file/scan"
    json = RestClient.post(url, apikey: Settings.vtapi_key, file: File.new(fpath, 'rb'))
    res = JSON.parse(json)
    if res["response_code"] == 1
      self.vtresource = res["resource"]
      self.vtscan_id = res["scan_id"]
      self.vtpermalink = res["permalink"]
      self.vtsha256 = res["sha256"]
      Resque.enqueue_at_with_queue(:main, 20.minutes.from_now, VtGetReportJob, app_id: self.id) # TODO this won't work
      progress(90, "Virus Total: Awaiting scan results")
    else
      # TODO better error handling
      progress(100, "Virus Total: Error -- please file bug report", false)
    end
  end

  def scrape
    # TODO per aid, find the last created_at and use its query_id to adjust
    # values
    case self.platform.to_sym
    when :android
      url = "https://play.google.com/store/apps/details?id=#{self.scrapeid}"
      # html = RestClient.get(url)
      # doc = Nokogiri::HTML(html)
      # TODO grab data we want
    else
      # TODO right now -- do nothing
    end
  end

  def self.perform(app_id, method, opts={})
    # if method.nil?
    # first parameter is a hash
    App.find(app_id).send(method, opts)
  end

  def self.valids
    App.where(proper: true, status: 100)
  end

  private

  def set_aid
    update_attribute(:aid, self.id) unless self.aid
  end
end
