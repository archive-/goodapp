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

  def valid_keys
    keys.where(status: 100, proper: true)
  end

  def valid_email_keys
    keys.where(status: 100, style: "email", proper: true)
  end

  def valid_apps
    apps.where(status: 100, proper: true)
  end

  def base_rating
    self.github_account.rating
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
