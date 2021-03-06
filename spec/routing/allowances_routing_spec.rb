require "spec_helper"

describe AllowancesController do
  describe "routing" do

    it "routes to #index" do
      get("/accounts/1/allowances").should route_to("allowances#index", account_id: "1")
    end

    it "routes to #new" do
      get("/accounts/1/allowances/new").should route_to("allowances#new", account_id: "1")
    end

    it "routes to #show" do
      get("/allowances/1").should route_to("allowances#show", id: "1")
    end

    it "routes to #edit" do
      get("/allowances/1/edit").should route_to("allowances#edit", id: "1")
    end

    it "routes to #create" do
      post("/accounts/1/allowances").should route_to("allowances#create", account_id: "1")
    end

    it "routes to #update" do
      put("/allowances/1").should route_to("allowances#update", id: "1")
    end

    it "routes to #destroy" do
      delete("/allowances/1").should route_to("allowances#destroy", id: "1")
    end

  end
end
