# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    description "MyString"
    amount 1.5
    paid_at "2013-04-14 16:34:36"
    account nil
  end
end
