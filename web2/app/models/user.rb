class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :keys
  has_many :apps, through: :keys

  def self.featured
    # TODO determined featured users list
    User.last(20)
  end
end
