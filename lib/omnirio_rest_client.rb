module OmnirioRestClient
  def self.get(url, headers = {}, &params_block)
    headers = { 'X-Request-Id' => SecureRandom.hex(16),
                        'X_CLIENT_ID' => 'account' }.merge(headers)
    Rails.logger.info("Making GET call to #{url} with headers = #{headers} .....")
    start_time = Time.now
    get_response = RestClient.get URI.encode(url), headers, &params_block
    Rails.logger.info("Finised in #{Time.now - start_time} sec")
    get_response
  rescue Exception => e
    Rails.logger.info("GET call FAILED: #{e.message}. Time taken:- #{Time.now - start_time} sec")
    e.try(:response)
  end

  def self.post(url, payload, headers = {}, &params_block)
    headers = { 'X-Request-Id' => SecureRandom.hex(16),
                'X_CLIENT_ID' => 'account' }.merge(headers)
    Rails.logger.info("Making POST call to #{url} with payload = #{payload}, headers = #{headers} .....")
    start_time = Time.now
    post_response = RestClient.post URI.encode(url), payload, headers, &params_block
    Rails.logger.info("Finised in #{Time.now - start_time} sec")
    post_response
  rescue Exception => e
    Rails.logger.info("POST call FAILED: #{e.message}. Time taken:- #{Time.now - start_time} sec")
    e.try(:response)
  end

  def self.put(url, payload, headers = {}, &params_block)
    headers = { 'X-Request-Id' => SecureRandom.hex(16),
                  'X_CLIENT_ID' => 'account' }.merge(headers)
    Rails.logger.info("Making PUT call to #{url} with payload = #{payload}, headers = #{headers} .....")
    start_time = Time.now
    put_response = RestClient.put URI.encode(url), payload, headers, &params_block
    Rails.logger.info("Finised in #{Time.now - start_time} sec")
    put_response
  rescue Exception => e
    Rails.logger.info("PUT call FAILED: #{e.message}. Time taken:- #{Time.now - start_time} sec")
    e.try(:response)
  end

  def self.delete(url, headers = {}, &params_block)
    headers = { 'X-Request-Id' => SecureRandom.hex(16),
                'X_CLIENT_ID' => 'account' }.merge(headers)
    Rails.logger.info("Making DELETE call to #{url} with headers = #{headers} .....")
    start_time = Time.now
    delete_response = RestClient.delete URI.encode(url), headers, &params_block
    Rails.logger.info("Finised in #{Time.now - start_time} sec")
    delete_response
  rescue Exception => e
    Rails.logger.info("DELETE call FAILED: #{e.message}. Time taken:- #{Time.now - start_time} sec")
    e.try(:response)
  end
end
