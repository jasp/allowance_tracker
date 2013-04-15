require 'spec_helper'

describe ExpensesController do

  def valid_attributes
    { "description" => "MyString", "amount" => 42, "paid_at" => '2013-04-05' }
  end

  describe "GET index" do
    it "assigns all expenses as @expenses" do
      expense = FactoryGirl.create :expense
      get :index, account_id: expense.account.to_param
      assigns(:expenses).should eq([expense])
    end

    it "does not include allowances for other accounts in @allowances" do
      expense = FactoryGirl.create :expense
      get :index, account_id: FactoryGirl.create(:account).to_param
      assigns(:expenses).should_not include(expense)
    end
  end

  describe "GET show" do
    it "assigns the requested expense as @expense" do
      expense = FactoryGirl.create :expense
      get :show, id: expense.to_param
      assigns(:expense).should eq(expense)
    end
  end

  describe "GET new" do
    it "assigns a new expense as @expense" do
      get :new, account_id: FactoryGirl.create(:account).to_param
      assigns(:expense).should be_a_new(Expense)
    end
  end

  describe "GET edit" do
    it "assigns the requested expense as @expense" do
      expense = FactoryGirl.create :expense
      get :edit, id: expense.to_param
      assigns(:expense).should eq(expense)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Expense" do
        account = FactoryGirl.create(:account)
        expect {
          post :create, account_id: account.to_param, expense: valid_attributes
        }.to change(Expense, :count).by(1)
      end

      it "assigns a newly created expense as @expense" do
        account = FactoryGirl.create(:account)
        post :create, account_id: account.to_param, expense: valid_attributes
        assigns(:expense).should be_a(Expense)
        assigns(:expense).should be_persisted
      end

      it "redirects to the created expense" do
        account = FactoryGirl.create(:account)
        post :create, account_id: account.to_param, expense: valid_attributes
        response.should redirect_to(account.expenses.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved expense as @expense" do
        # Trigger the behavior that occurs when invalid params are submitted
        Expense.any_instance.stub(:save).and_return(false)
        account = FactoryGirl.create(:account)
        post :create, account_id: account.to_param, expense: { "amount" => "invalid value"}
        assigns(:expense).should be_a_new(Expense)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Expense.any_instance.stub(:save).and_return(false)
        account = FactoryGirl.create(:account)
        post :create, account_id: account.to_param, expense: { "amount" => "invalid value"}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested expense" do
        expense = FactoryGirl.create :expense
        # Assuming there are no other expenses in the database, this
        # specifies that the Expense created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Expense.any_instance.should_receive(:update_attributes).with({ "description" => "MyString" })
        put :update, :id => expense.to_param, :expense => { "description" => "MyString" }
      end

      it "assigns the requested expense as @expense" do
        expense = FactoryGirl.create :expense
        put :update, :id => expense.to_param, :expense => valid_attributes
        assigns(:expense).should eq(expense)
      end

      it "redirects to the expense" do
        expense = FactoryGirl.create :expense
        put :update, :id => expense.to_param, :expense => valid_attributes
        response.should redirect_to(expense)
      end
    end

    describe "with invalid params" do
      it "assigns the expense as @expense" do
        expense = FactoryGirl.create :expense
        # Trigger the behavior that occurs when invalid params are submitted
        Expense.any_instance.stub(:save).and_return(false)
        put :update, :id => expense.to_param, :expense => { "amount" => "invalid value" }
        assigns(:expense).should eq(expense)
      end

      it "re-renders the 'edit' template" do
        expense = FactoryGirl.create :expense
        # Trigger the behavior that occurs when invalid params are submitted
        Expense.any_instance.stub(:save).and_return(false)
        put :update, :id => expense.to_param, :expense => { "amount" => "invalid value" }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested expense" do
      expense = FactoryGirl.create :expense
      expect {
        delete :destroy, :id => expense.to_param
      }.to change(Expense, :count).by(-1)
    end

    it "redirects to the expenses list" do
      expense = FactoryGirl.create :expense
      delete :destroy, :id => expense.to_param
      response.should redirect_to(account_expenses_url(expense.account))
    end
  end

end
