module ApplicationHelper
	def current_user
    return unless session[:current_user]
    @current_user ||= session[:user_id] && session[:current_user]
  end

  def set_current_user_session(response)
    # Correct this with new sign in response. Important    
    parsed_response = JSON.parse(response)
    logged_in_as = parsed_response["data"]["logged_in_as"]
    parsed_response["data"]["data"] = { logged_in_as => parsed_response["data"][logged_in_as]} if parsed_response["data"]["data"].blank?
    header = response.headers
    session[:user_id] = parsed_response["data"]["id"]
    session[:uid] = header[:uid]
    session[:client] = header[:client]
    session[:access_token] = header[:access_token]
    user = parsed_response["data"]
    session[:current_user] = parsed_response["data"]
  end

  def is_branch_manager?
    (current_user.present? && current_user["roles"].include?("branch_manager") && current_user["logged_in_as"] == "branch_manager") ? true : false
  end

  def is_customer?
    (current_user.present? && current_user["roles"].include?("customer") && current_user["logged_in_as"] == "customer") ? true : false
  end
end
