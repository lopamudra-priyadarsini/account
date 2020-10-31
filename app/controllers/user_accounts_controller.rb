class UserAccountsController < ApplicationController
  include application_helper
  before_action :set_user_account, only: [:show, :edit, :update, :destroy]

  # GET /user_accounts
  # GET /user_accounts.json
  def index
    if is_branch_manager?
      @user_accounts = UserAccount.all
      success_response(message: 'All Accounts', data: { user_accounts: @user_accounts })
    else
      error_response(message: response.status_message, data: response.data)
    end
  end

  # GET /user_accounts/1
  # GET /user_accounts/1.json
  def show
    success_response(message: 'Account', data: { user_account: @user_account })
  end

  # GET /user_accounts/new
  def new
    @user_account = UserAccount.new
  end

  # GET /user_accounts/1/edit
  def edit
  end

  # POST /user_accounts
  # POST /user_accounts.json
  def create
    response = UserAccount::Create.call(user_account_params)
    if response.success?
      success_response(message: response.status_message, http_status: 202, data: response.data)
    else
      error_response(message: response.status_message, data: response.data)
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    response = UserAccount::Update.call(user_account_params)
    if response.success?
      success_response(message: response.status_message, http_status: 202, data: response.data)
    else
      error_response(message: response.status_message, data: response.data)
    end
  end

  # PATCH/PUT /user_accounts/1
  # PATCH/PUT /user_accounts/1.json

  # DELETE /user_accounts/1
  # DELETE /user_accounts/1.json
  def destroy
    @user_account.destroy
    respond_to do |format|
      format.html { redirect_to user_accounts_url, notice: 'User account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_account
      @user_account = UserAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_account_params
      params.fetch(:user_account, {})
    end

    def create_params
    params.require(:user_account).permit(:account_type, :open_date, :customer_id, :customer_name, :branch, :account_for_self)
  end
end
