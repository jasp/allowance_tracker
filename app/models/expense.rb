class Expense < ActiveRecord::Base
  belongs_to :account
  attr_accessible :amount, :description, :paid_at
end
