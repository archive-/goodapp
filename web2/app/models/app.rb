class App < ActiveRecord::Base
  attr_accessible #none

  belongs_to :key

  after_save :set_aid

  @queue = :main #:apps

  # how status # works:
  #  0- 40: parsing data, handling the binary upload
  # 40- 70: sending to virus total
  # 70-100: retrieving results from virus total, finishing

  def state
    case self.status
    when 0..40
      "Extracting app metadata"
    when 40..70
      "Scanning app for malware"
    when 70...100
      "Finalizing"
    else
      # TODO should never happen
      "Error"
    end
  end

  def user
    key.user
  end

  def handle_upload(file, key)
    self.status, self.proper = 10, true ; save # start it at 10 to give hope
    # TODO this is bad -- but file past in gets deleted after the response
    base = rand(36 ** 8).to_s(36)
    tmp = File.new(File.join(Rails.root, "tmp/uploads/#{base}"), "wb")
    tmp.write(file.read)
    fpath = File.absolute_path(tmp)
    # TODO don't close it yet (we need it for async method, don't like this
    # solution though...
    case file.content_type
    when "application/vnd.android.package-archive"
      Resque.enqueue(App, self.id, :handle_apk, fpath, key.kee)
    else
      self.status, self.proper = 100, false ; save
      return false
    end
    true
  end

  def handle_apk(fpath, kee)
    # TODO
    # unzip
    # cat META-INF/CERT.RSA | keytool -printcert
    # check with key
    Dir.mktmpdir do |tmpdir|
      apkout = `apktool d -f #{fpath} #{tmpdir}`
      Dir.chdir(tmpdir) do
        File.open("AndroidManifest.xml", "r") do |manifest|
          # TODO parse XML -- not string
          content = manifest.read
          self.version = content.match(/android:versionName="([^"]*)"/)[1]
          self.title = content.match(/application android:label="([^"]*)"/)[1]
          self.platform = :android
          self.status = 40 ; save
        end
      end
    end
    self.scan(fpath)
  rescue Exception => e
    # TODO store/log the exception
    puts e.message
    self.status, self.proper = 100, false ; save
  ensure
    # TODO delete the temp file now
    File.unlink(fpath)
  end

  def scan(fpath, force=false)
    return if self.vtpermalink and !force
    self.status = 70 ; save
    url = "https://www.virustotal.com/vtapi/v2/file/scan"
    json = RestClient.post(url, key: Settings.vtapi_key, file: File.new(fpath, 'rb'))
    res = JSON.parse(json)
    if res["response_code"] == 1
      self.vtresource = res["resource"]
      self.vtscan_id = res["scan_id"]
      self.vtpermalink = res["permalink"]
      self.vtsha256 = res["sha256"]
      self.status = 100 ; save
    else
      # TODO better error handling
      self.status, self.proper = 100, false ; save
    end
  end

  def self.perform(app_id, handle_method, fpath, kee)
    App.find(app_id).send(handle_method, fpath, kee)
  end

  private

  def set_aid
    update_attribute(:aid, self.id) unless self.aid
  end
end
