class Expense < ActiveRecord::Base
  belongs_to :account
  attr_accessible :amount, :description, :paid_at
  validates_presence_of :paid_at
  validates_presence_of :account
end
