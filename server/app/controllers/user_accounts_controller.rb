class UserAccountsController < ApplicationController
  load_and_authorize_resource

  # GET /user_accounts
  # GET /user_accounts.json
  def index
    @user = User.find(params[:user_id])
    @user_accounts = @user.user_accounts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_accounts }
      format.xml  { render xml: @user_accounts }
    end
  end

  # GET /user_accounts/1
  # GET /user_accounts/1.json
  def show
    @user_account = UserAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_account }
      format.xml  { render xml: @user_account }
    end
  end

  # GET /user_accounts/new
  # GET /user_accounts/new.json
  def new
    @user_account = UserAccount.new
    @user_account.user = User.find(params[:user_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_account }
      format.xml  { render xml: @user_account }
    end
  end

  # GET /user_accounts/1/edit
  def edit
    @user_account = UserAccount.find(params[:id])
  end

  # POST /user_accounts
  # POST /user_accounts.json
  def create
    @user_account = UserAccount.new(params[:user_account])

    respond_to do |format|
      if @user_account.save
        format.html { redirect_to user_account_url(@user_account.user, @user_account), notice: 'User account was successfully created.' }
        format.json { render json: @user_account, status: :created, location: @user_account }
        format.xml  { render xml: @user_account, status: :created, location: @user_account }
      else
        format.html { render action: "new" }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
        format.xml  { render xml: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_accounts/1
  # PUT /user_accounts/1.json
  def update
    @user_account = UserAccount.find(params[:id])

    respond_to do |format|
      if @user_account.update_attributes(params[:user_account])
        format.html { redirect_to user_account_url(@user_account.user, @user_account), notice: 'User account was successfully updated.' }
        format.json { head :ok }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
        format.xml  { render xml: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_accounts/1
  # DELETE /user_accounts/1.json
  def destroy
    @user_account = UserAccount.find(params[:id])
    @user_account.destroy

    respond_to do |format|
      format.html { redirect_to user_accounts_url }
      format.json { head :ok }
      format.xml  { head :ok }
    end
  end
end
