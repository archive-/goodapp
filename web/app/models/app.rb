class App < ActiveRecord::Base
  validates :name, :presence => true
  validates_attachment_content_type :logo, :content_type => /image/
  validates_attachment_presence :file

  has_attached_file :logo, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  has_attached_file :file

  has_many :app_ownerships
  has_many :owners, :through => :app_ownerships, :source => :user
  has_many :app_usages
  has_many :users, :through => :app_usages, :source => :user
end
