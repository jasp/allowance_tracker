require 'spec_helper'

describe Allowance do
  subject { FactoryGirl.build(:allowance) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  it "requires a starting date" do
    subject.started_at = nil
    expect(subject).to_not be_valid
  end

  it "started_at must come before ended_at" do
    subject.ended_at = subject.started_at
    expect(subject).to_not be_valid
    subject.ended_at = subject.started_at - 1.month
    expect(subject).to_not be_valid
  end
end
