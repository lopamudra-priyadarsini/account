class CustomerService
	def get_user(params, headers)
    Rails.logger.info("PMS. get dashboard called with: #{header.inspect}")
    OmnirioRestClient.get("http://localhost:3002/users/params['user_id']", header)
    end
	end

	def create_user(params, headers)
    Rails.logger.info("PMS. get dashboard called with: #{header.inspect}")
    OmnirioRestClient.post("http://localhost:3002/users/params", header)
    end
end
