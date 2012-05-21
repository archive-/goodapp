class Key < ActiveRecord::Base
  attr_accessible :title, :kee

  belongs_to :user
  has_many :apps

  validates_uniqueness_of :kee
  validates_uniqueness_of :title, scope: :user_id
end
