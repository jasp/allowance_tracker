class AllowancesController < ApplicationController
  # GET /allowances
  # GET /allowances.json
  def index
    @account = Account.find(params[:account_id])
    @allowances = @account.allowances.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @allowances }
    end
  end

  # GET /allowances/1
  # GET /allowances/1.json
  def show
    @allowance = Allowance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @allowance }
    end
  end

  # GET /allowances/new
  # GET /allowances/new.json
  def new
    @account = Account.find(params[:account_id])
    @allowance = @account.allowances.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @allowance }
    end
  end

  # GET /allowances/1/edit
  def edit
    @allowance = Allowance.find(params[:id])
  end

  # POST /allowances
  # POST /allowances.json
  def create
    @account = Account.find(params[:account_id])
    @allowance = @account.allowances.build(params[:allowance])

    respond_to do |format|
      if @allowance.save
        format.html { redirect_to @allowance, notice: 'Allowance was successfully created.' }
        format.json { render json: @allowance, status: :created, location: @allowance }
      else
        format.html { render action: "new" }
        format.json { render json: @allowance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /allowances/1
  # PUT /allowances/1.json
  def update
    @allowance = Allowance.find(params[:id])

    respond_to do |format|
      if @allowance.update_attributes(params[:allowance])
        format.html { redirect_to @allowance, notice: 'Allowance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @allowance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allowances/1
  # DELETE /allowances/1.json
  def destroy
    @allowance = Allowance.find(params[:id])
    @account = @allowance.account
    @allowance.destroy

    respond_to do |format|
      format.html { redirect_to account_allowances_url(@account) }
      format.json { head :no_content }
    end
  end
end
