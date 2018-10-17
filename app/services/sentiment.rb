class Sentiment
	require "uri"
	require "net/https"

	attr_accessor :response

  def initialize(data)
		puts "sentiment has been initialized"
		@response = []
		@data = data
  end

  def send
		@data.each do | tweet |
			uri = URI.parse("https://text-sentiment.p.mashape.com/analyze")
			headers = {
				'X-Mashape-Key':ENV['MASHAPE_SENTIMENT'],
				'Content-Type':'application/x-www-form-urlencoded',
				'Accept':'application/json' }
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Post.new(uri.request_uri, headers)
			request.set_form_data('text' => tweet)

			p request
			puts request
			response = http.request(request)

			@response.append(response.body)

		end
  end
end
