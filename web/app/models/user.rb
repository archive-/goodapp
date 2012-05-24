class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable,
   :confirmable

  attr_accessible :name, :about, :email, :password,
    :password_confirmation, :remember_me

  has_many :keys, dependent: :delete_all
  has_many :apps, through: :keys

  validates_presence_of :name

  def valid_keys
    keys.where(status: 100, proper: true)
  end

  # TODO with high activity?
  # TODO maybe most trusted users??
  def self.featured
    # TODO determined featured users list
    User.last(5)
  end
end
