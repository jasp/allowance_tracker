require 'spec_helper'

describe AllowancesController do

  # This should return the minimal set of attributes required to create a valid
  # Allowance. As you add validations to Allowance, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "amount" => "1.5", "started_at" => "2013-04-01" }
  end

  describe "GET index" do
    it "assigns all allowances for account as @allowances" do
      allowance = FactoryGirl.create :allowance
      get :index, account_id: allowance.account.to_param
      assigns(:allowances).should eq([allowance])
    end

    it "does not include allowances for other accounts in @allowances" do
      allowance = FactoryGirl.create :allowance
      get :index, account_id: FactoryGirl.create(:account).to_param
      assigns(:allowances).should_not include(allowance)
    end
  end

  describe "GET show" do
    it "assigns the requested allowance as @allowance" do
      allowance = FactoryGirl.create :allowance
      get :show, :id => allowance.to_param
      assigns(:allowance).should eq(allowance)
    end
  end

  describe "GET new" do
    it "assigns a new allowance as @allowance" do
      account = FactoryGirl.create :account
      get :new, account_id: account.to_param
      assigns(:allowance).should be_a_new(Allowance)
    end
  end

  describe "GET edit" do
    it "assigns the requested allowance as @allowance" do
      allowance = FactoryGirl.create :allowance
      get :edit, :id => allowance.to_param
      assigns(:allowance).should eq(allowance)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Allowance" do
        account = FactoryGirl.create :account
        expect {
          post :create, account_id: account.to_param, allowance: valid_attributes
        }.to change(Allowance, :count).by(1)
      end

      it "assigns a newly created allowance as @allowance" do
        account = FactoryGirl.create :account
        post :create, account_id: account.to_param, allowance: valid_attributes
        assigns(:allowance).should be_a(Allowance)
        assigns(:allowance).should be_persisted
      end

      it "redirects to the created allowance" do
        account = FactoryGirl.create :account
        post :create, account_id: account.to_param, allowance: valid_attributes
        response.should redirect_to(Allowance.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved allowance as @allowance" do
        # Trigger the behavior that occurs when invalid params are submitted
        account = FactoryGirl.create :account
        Allowance.any_instance.stub(:save).and_return(false)
        post :create, account_id: account.to_param, allowance: { started_at: 'invalid value' }
        assigns(:allowance).should be_a_new(Allowance)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        account = FactoryGirl.create :account
        Allowance.any_instance.stub(:save).and_return(false)
        post :create, account_id: account.to_param, allowance: { started_at: 'invalid value' }
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested allowance" do
        allowance = FactoryGirl.create :allowance
        # Assuming there are no other allowances in the database, this
        # specifies that the Allowance created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Allowance.any_instance.should_receive(:update_attributes).with({ "amount" => "1.5" })
        put :update, :id => allowance.to_param, :allowance => { "amount" => "1.5" }
      end

      it "assigns the requested allowance as @allowance" do
        allowance = FactoryGirl.create :allowance
        put :update, :id => allowance.to_param, :allowance => valid_attributes
        assigns(:allowance).should eq(allowance)
      end

      it "redirects to the allowance" do
        allowance = FactoryGirl.create :allowance
        put :update, :id => allowance.to_param, :allowance => valid_attributes
        response.should redirect_to(allowance)
      end
    end

    describe "with invalid params" do
      it "assigns the allowance as @allowance" do
        allowance = FactoryGirl.create :allowance
        # Trigger the behavior that occurs when invalid params are submitted
        Allowance.any_instance.stub(:save).and_return(false)
        put :update, :id => allowance.to_param, :allowance => { "started_at" => "invalid value" }
        assigns(:allowance).should eq(allowance)
      end

      it "re-renders the 'edit' template" do
        allowance = FactoryGirl.create :allowance
        # Trigger the behavior that occurs when invalid params are submitted
        Allowance.any_instance.stub(:save).and_return(false)
        put :update, :id => allowance.to_param, :allowance => { "started_at" => "invalid value" }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested allowance" do
      allowance = FactoryGirl.create :allowance
      expect {
        delete :destroy, :id => allowance.to_param
      }.to change(Allowance, :count).by(-1)
    end

    it "redirects to the allowances list" do
      allowance = FactoryGirl.create :allowance
      delete :destroy, :id => allowance.to_param
      response.should redirect_to(account_allowances_url(allowance.account))
    end
  end

end
