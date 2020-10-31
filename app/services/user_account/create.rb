class UserAccount::Create < ApplicationService
  include application_helper

  def initialize(options)
    options['account_for_self'] = options["account_for_self"].presence || 'true' #to check if the account is being created by self or someone else
    @create_params = options
    if options[]
    super(options)
  end

  def call
    create
  end

  def create
    if @create_params['account_for_self'] == 'true' && current_user['user_id'].empty?
      create_user
    else
      @user = get_user(current_user['user_id'])
    end
    if @create_params['account_for_self'] == 'false' && @create_params['customer_id'].empty?
      create_user
    else
      @user = get_user(@create_params['customer_id'])
    end

    unless @user.present
      error_response(message: "Unprocessable Entity")
    end
    @create_params["customer_id"] = @user['id']
    @create_params["customer_name"] = current_user['user_name']
    @create_params["minority_indication"] = user_age >= 18 ? false : true
    user_account = UserAccount.create(@create_params)
      if user_account
        success_response(message: 'User Account succesfully created', data:  {user_account: user_account})
      else
        error_response(message: user_account.errors.to_sentence, data:  {user_account: user_account})
      end
    end
  end

  private


  def get_user(user_id)
    response = CustomerService.get_user(user_id, @header)
    response_body = JSON.parse(response)
    if response.code == 200
      @user = response_body["data"]["user"]
    end
  end

  def user_age
  age = ((Time.zone.now - self.date_of_birth.to_time) / 1.year.seconds).floor
 end

end