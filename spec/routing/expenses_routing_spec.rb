require "spec_helper"

describe ExpensesController do
  describe "routing" do

    it "routes to #index" do
      get("/accounts/1/expenses").should route_to("expenses#index", account_id: "1")
    end

    it "routes to #new" do
      get("/accounts/1/expenses/new").should route_to("expenses#new", account_id: "1")
    end

    it "routes to #show" do
      get("/expenses/1").should route_to("expenses#show", id: "1")
    end

    it "routes to #edit" do
      get("/expenses/1/edit").should route_to("expenses#edit", id: "1")
    end

    it "routes to #create" do
      post("/accounts/1/expenses").should route_to("expenses#create", account_id: "1")
    end

    it "routes to #update" do
      put("/expenses/1").should route_to("expenses#update", id: "1")
    end

    it "routes to #destroy" do
      delete("/expenses/1").should route_to("expenses#destroy", id: "1")
    end

  end
end
