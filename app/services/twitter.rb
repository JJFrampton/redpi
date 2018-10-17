class Twitter
	require "uri"
	# twitter only accepts ssl
	require "net/https"

	puts ENV
	puts ENV['CONSUMER_API_KEY']

	attr_accessor :response

  # should use environment variables!
  @consumer_api_key = ENV['CONSUMER_API_KEY']
  @consumer_api_secret_key = ENV['CONSUMER_API_SECRET_KEY']
  @access_token = ENV['ACCESS_TOKEN']
  @access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  @bearer = Base64.encode64("#{@consumer_api_key}:#{@consumer_api_secret_key}")
  def initialize
		puts "twitter has been initialized"
		@response = ''
  end

  def authorize
		# still need to include a body of:
		# grant_type:client_credentials
		uri = URI.parse("https://api.twitter.com/oauth2/token")
		# should be dynamic
		headers = {
			'Authorization':ENV['AUTHORIZE_AUTHORIZATION'],
			'Content-Type':'application/x-www-form-urlencoded' }
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, headers)
		response = http.request(request)
		puts response.body
  end
  def search_for(search_term)
		uri = URI.parse("https://api.twitter.com/1.1/search/tweets.json?q=#{search_term}")
		# should be dynamic
		headers = {
			'Authorization':ENV['SEARCH_AUTHORIZATION'] }
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(uri.request_uri, headers)
		response = http.request(request)
		# puts 'puts response.body'
		# puts response.body

		@response = response.body

		# need to check response for this:
		# {"errors":[{"message":"Invalid or expired token","code":89}]}
		# if this is the response then you will need to trigger a new authorize call
		# can probably check if error and error[code] = 89
  end
end
