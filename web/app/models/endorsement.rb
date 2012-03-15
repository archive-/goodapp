class Endorsement < ActiveRecord::Base
  belongs_to :endorser, :class_name => :user
  belongs_to :endorsee, :class_name => :user
end
