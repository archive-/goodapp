class Key < ActiveRecord::Base
  attr_accessible :title, :key

  belongs_to :user
  has_many :apps

  validates_uniqueness_of :key
  validates_uniqueness_of :title, scope: :user_id
end
