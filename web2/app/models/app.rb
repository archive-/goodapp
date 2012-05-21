class App < ActiveRecord::Base
  attr_accessible #none

  belongs_to :key

  after_save :set_aid

  def user
    key.user
  end

  def handle_upload(file, key)
    case file.content_type
    when "application/vnd.android.package-archive"
      self.status = 0
      self.save
      handle_android(file, key)
    else
      return false
    end
    true
  end

  def handle_android(file, key)
    # TODO
    # unzip
    # cat META-INF/CERT.RSA | keytool -printcert
    # check with key
    Dir.mktmpdir do |tmpdir|
      apkout = `apktool d -f #{File.absolute_path(file.tempfile)} #{tmpdir}`
      Dir.chdir(tmpdir) do
        File.open("AndroidManifest.xml", "r") do |manifest|
          # TODO parse XML -- not string
          # parse out the title, version, and logo
          content = manifest.read
          self.version = content.match(/android:versionName="([^"]*)"/)[1]
          self.title = content.match(/application android:label="([^"]*)"/)[1]
          self.platform = :android
          self.status = 100
          self.save
        end
      end
    end
  end
  # TODO do all the asynchronous handles in a loop
  handle_asynchronously :handle_android

  private

  def set_aid
    update_attribute(:aid, self.id) unless self.aid
  end
end
