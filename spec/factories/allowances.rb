# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :allowance do
    amount 1.5
    started_at "2013-04-1"
    ended_at "2013-04-30 23:59:59"
    account nil
  end
end
