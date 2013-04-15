require 'spec_helper'

describe Account do
  subject { FactoryGirl.build(:account) }
  it "has a valid factory" do
    expect(subject).to be_valid
  end

  describe "#current_allowance" do
    it "calculates allowance for this month" do
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_month)
      expect(subject.current_allowance).to eq(200)
    end

    it "sums up multiple valid allowances" do
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_month)
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_year)
      expect(subject.current_allowance).to eq(400)
    end

    it "ignores allowances that have been stopped" do
      subject.allowances.build(amount: 200,
                               started_at: Time.zone.now.end_of_month - 1.year,
                               ended_at: Time.zone.now.beginning_of_year)
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_year)
      expect(subject.current_allowance).to eq(200)
    end

    it "ignores allowances that have not been started yet" do
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_month + 1.month)
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_year)
      expect(subject.current_allowance).to eq(200)
    end

    it "can calculate allowance for past dates" do
      subject.allowances.build(amount: 200,
                               started_at: Time.zone.now.beginning_of_month,
                               ended_at: Time.zone.now.end_of_month)
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_year)
      expect(subject.current_allowance(Time.zone.now + 1.month)).to eq(200)
    end

    it "can calculate allowance for future dates" do
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_month + 1.month)
      subject.allowances.build(amount: 200, started_at: Time.zone.now.beginning_of_year)
      expect(subject.current_allowance(Time.zone.now + 2.months)).to eq(400)
    end
  end

  describe "#total_allowance" do
    it "calculates the total allowance afforded until today" do
      now = Time.zone.local(2013, 5, 5)
      subject.allowances.build(amount: 200, started_at: now.beginning_of_year)
      expect(subject.total_allowance(now)).to eq(1000)
    end

    it "calculates the total allowance afforded until beginning_of_month" do
      now = Time.zone.local(2013, 5, 5).beginning_of_month
      subject.allowances.build(amount: 200, started_at: now.beginning_of_year)
      expect(subject.total_allowance(now)).to eq(1000)
    end

    it "calculates the total allowance afforded until end_of_month" do
      now = Time.zone.local(2013, 5, 5).end_of_month
      subject.allowances.build(amount: 200, started_at: now.beginning_of_year)
      expect(subject.total_allowance(now)).to eq(1000)
    end

    it "accounts for ended_at on allowance" do
      now = Time.zone.local(2013, 5, 5)
      subject.allowances.build(amount: 200,
                               started_at: now.beginning_of_year,
                               ended_at: now.end_of_month)
      expect(subject.total_allowance(now + 1.year)).to eq(1000)
    end

    it "calculates total allowance for multiple allowances" do
      now = Time.zone.local(2013, 5, 5)
      subject.allowances.build(amount: 200, started_at: now.beginning_of_year)
      subject.allowances.build(amount: 200, started_at: (now - 1.year).beginning_of_year)
      expect(subject.total_allowance(now)).to eq(4400)
    end
  end

  describe '#total_expenses' do
    it "calculates sum of all expenses for account" do
      now = Time.zone.local(2013, 5, 5)
      subject.save!
      subject.expenses.create(amount: 256, paid_at: now - 1.day)
      subject.expenses.create(amount: 42, paid_at: now - 2.days)
      expect(subject.total_expenses).to eq(298)
    end
  end

  describe '#current_balance' do
    it "calculates sum of all expenses for account" do
      now = Time.zone.local(2013, 5, 5)
      subject.save!
      subject.expenses.create(amount: 256, paid_at: now - 1.day)
      subject.expenses.create(amount: 42, paid_at: now - 2.days)
      subject.allowances.create(amount: 200, started_at: now.beginning_of_month - 1.month)
      expect(subject.current_balance(now)).to eq(400 - 298)
    end
  end
end
