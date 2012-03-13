class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :about, :avatar

  attr_accessor :password
  before_save :encrypt_password

  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true, :email => true
  validates :password, :presence => true, :confirmation => true, :on => :create

  has_attached_file :avatar, :styles => {:medium => "300x300>", :profile => "180x180>", :thumb => "100x100>"}, :default_url => '/assets/default-profile.jpg'

  has_many :app_ownerships
  has_many :owned_apps, :through => :app_ownerships, :source => :app
  has_many :app_usages
  has_many :used_apps, :through => :app_usages, :source => :app

  def self.authenticate(email, password)
    user = find_by_email(email)
    user if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def admin?
    self.name == 'admin' # TODO
  end
end
