class Endorsement < ActiveRecord::Base
  attr_accessible :endorsee_id, :comment

  belongs_to :endorser, class_name: "User"
  belongs_to :endorsee, class_name: "User"

  validates :endorsee_id,
    presence: true,
    uniqueness: {scope: :endorser_id}
  validate :not_yourself

  def not_yourself
    errors.add(:endorsee_id, "can't be yourself") if endorser_id == endorsee_id
  end

  def self.queue_resync
    Resque.enqueue(EndorsementRatingSyncJob)
  end
end
