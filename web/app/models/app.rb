class App < ActiveRecord::Base
  validates :name, :presence => true
  validates_attachment_content_type :logo, :content_type => /image/
  validates_attachment_presence :file

  has_attached_file :logo, :styles => {:medium => "300x300>", :thumb => "60x60#"}, :default_url => '/assets/no_logo_uploaded.png'
  has_attached_file :file

  has_many :app_ownerships
  has_many :owners, :through => :app_ownerships, :source => :user
  has_many :app_usages
  has_many :users, :through => :app_usages, :source => :user

  after_save :scan
  has_many :basic_feedbacks

  private

  def scan
    # TODO limit when this scan occurs
    url = 'https://wwww.virustotal.com/vtapi/v2/file/scan'
    json = RestClient.post(url, :key => Settings.vtapi_key,
                          :file => File.new(self.file.path, 'rb'))
    res = JSON.parse(json)
    puts res
    if res['response_code'] == 1
      sr = self.build_scan_result
      sr.vtresource = res['resource']
      sr.vtscan_id = res['scan_id']
      sr.vtpermalink = res['permalink']
      sr.sha256 = res['sha256']
      sr.save
    end
  end

  handle_asynchronously :scan
end
