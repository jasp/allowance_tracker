require 'spec_helper'

describe "Allowances" do
  describe "GET /allowances" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      account = FactoryGirl.create :account
      get account_allowances_path(account)
      response.status.should be(200)
    end
  end
end
