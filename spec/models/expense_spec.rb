require 'spec_helper'

describe Expense do
  subject { FactoryGirl.build :expense }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  it "must have a paid date" do
    subject.paid_at = nil
    expect(subject).to have(1).error_on(:paid_at)
  end

  it "must have an amount" do
    subject.amount = nil
    expect(subject).to have(1).error_on(:amount)
  end

  it "must belong to an account" do
    subject.account = nil
    expect(subject).to have(1).error_on(:account)
  end
end
