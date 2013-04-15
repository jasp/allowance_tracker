require 'spec_helper'

describe "Expenses" do
  describe "GET /expenses" do
    it "works! (now write some real specs)" do
      account = FactoryGirl.create :account
      get account_expenses_path(account)
      response.status.should be(200)
    end
  end
end
