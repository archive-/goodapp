class App < ActiveRecord::Base
  belongs_to :key

  def user
    key.user
  end

  def self.handle_upload(file)
    case file.content_type
    when "application/vnd.android.package-archive"
      handle_android(file)
    else
      return false
    end
    true
  end

  def self.handle_android(file)
    # TODO
    # unzip
    # cat META-INF/CERT.RSA | keytool -printcert
    # check with key
  end
end
