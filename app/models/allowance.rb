class Allowance < ActiveRecord::Base
  belongs_to :account
  attr_accessible :amount, :ended_at, :started_at
  validates_presence_of :started_at
  validate :ended_must_come_after_started

  def ended_must_come_after_started
    if ended_at and started_at and started_at >= ended_at
      errors.add(:ended_at, "comes before started_at")
    end
  end
end
