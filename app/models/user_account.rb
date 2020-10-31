class UserAccount < ApplicationRecord
	validates_presence_of :user_id
	CREATE_KEYS = [:account_type, :open_date, :customer_id, :customer_name, :branch, :minor_indicator]
  UPDATE_KEYS = [:account_type, :customer_name, :branch] 

  enum minority_indicator: [ :true, :false ]

end