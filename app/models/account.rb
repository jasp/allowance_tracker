class Account < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :allowances
  has_many :expenses

  def current_allowance(now = Time.zone.now)
    first = now.beginning_of_month
    last = first.end_of_month
    allowances.inject(0) do |sum, a|
      if a.ended_at and a.ended_at <= first or a.started_at > last
        sum
      else
        sum + a.amount
      end
    end
  end

  def total_allowance(now = Time.zone.now)
    allowances.inject(0) do |sum, a|
      last = (a.ended_at and a.ended_at < now) ? a.ended_at : now
      sum + a.amount * months_between(a.started_at, last)
    end
  end

  def total_expenses
    expenses.sum('amount')
  end

  def current_balance(now = Time.zone.now)
    total_allowance(now) - total_expenses
  end

  private

  def months_between(a, b)
    if a < b
      months = (b.year - a.year) * 12 + (1 + b.month - a.month)
    else
      0
    end
  end
end
