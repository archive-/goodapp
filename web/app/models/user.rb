class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable,
   :confirmable

  attr_accessible :name, :about, :email, :password,
    :password_confirmation, :remember_me

  has_many :keys, dependent: :delete_all
  has_many :apps, through: :keys

  has_many :endorsements_as_endorser, foreign_key: :endorser_id, class_name: "Endorsement", dependent: :delete_all
  has_many :endorsements_as_endorsee, foreign_key: :endorsee_id, class_name: "Endorsement", dependent: :delete_all
  has_many :endorsees, through: :endorsements_as_endorser
  has_many :endorsers, through: :endorsements_as_endorsee

  has_one :github_account

  validates_presence_of :name

  auto_strip :name, :email, :about

  def valid_keys
    keys.where(status: 100, proper: true)
  end

  def valid_email_keys
    keys.where(status: 100, style: "email", proper: true)
  end

  def valid_apps
    apps.where(status: 100, proper: true)
  end

  def avg_app_rating
    return 0.0 if self.valid_apps.empty?
    self.valid_apps.map {|a| a.rating}.inject(:+).to_f / self.valid_apps.count
  end

  def max_email_key
    self.valid_email_keys.max {|a, b| (a.rating || 0.0) <=> (b.rating || 0.0)}
  end

  def max_email_key_rating
    mek = max_email_key
    # because key.rating can be nil (if not email key -- *poor* design)
    mek ? (mek.rating || 0.0) : 0.0
  end

  def base_rating
    base_rating = 0.0
    # GITHUB - 10%
    base_rating += self.github_account.rating * 10.0 if self.github_account
    # CORPORATE EMAIL - 10%
    base_rating += self.max_email_key_rating * 10.0
    # APPS
    base_rating += self.avg_app_rating * 40.0
    base_rating
  end

  # calculated and stored
  def rating
    self.base_rating
  end

  # TODO with high activity?
  # TODO maybe most trusted users??
  def self.featured
    # TODO determined featured users list
    User.last(5)
  end
end
