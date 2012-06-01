class Endorsement < ActiveRecord::Base
  belongs_to :endorser, class_name: "User"
  belongs_to :endorsee, class_name: "User"

  attr_accessible :endorsee_id, :comment

  validates :endorsee_id,
    presence: true,
    uniqueness: {scope: :endorser_id}
  validate :not_yourself

  def not_yourself
    errors.add(:endorsee_id, "can't be yourself") if endorser_id == endorsee_id
  end
end
