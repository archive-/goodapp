class App < ActiveRecord::Base
  attr_accessible #none

  belongs_to :key

  after_save :set_aid

  @queue = :main

  def user
    key.user
  end

  def handle_upload(file, key)
    self.status, self.proper = 0, true ; self.save
    # TODO this is bad -- but file past in gets deleted after the response
    rand = (0...5).map { (65 + rand(25)).chr }.join
    tmp = File.new(File.join(Rails.root, "tmp/uploads/#{rand}"), "wb")
    tmp.write(file.read)
    fpath = File.absolute_path(lesstmpfile)
    # TODO don't close it yet (we need it for async method, don't like this
    # solution though...
    case file.content_type
    when "application/vnd.android.package-archive"
      Resque.enqueue(App, self.id, :handle_apk, fpath, key.kee)
    else
      self.status, self.proper = 100, false ; self.save
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
          self.status = 100 ; save
        end
      end
    end
  rescue Exception => e
    # TODO store/log the exception
    puts e.message
    self.status, self.proper = 100, false ; save
  ensure
    # TODO delete the temp file now
    File.unlink(fpath)
  end

  def self.perform(app_id, handle_method, fpath, kee)
    App.find(app_id).send(handle_method, fpath, kee)
  end

  private

  def set_aid
    update_attribute(:aid, self.id) unless self.aid
  end
end
