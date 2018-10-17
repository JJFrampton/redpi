class TwitterController < ApplicationController
  def search
    # service twitter
    twitter = Twitter.new()
    #   send request
    twitter.search_for(params[:q])
		# 	if failed the get auth then retry
    #   harvest sentences from response
		data_formater = FormatDataForSentiment.new(twitter.response)
		data_formater.perform
    p "data_formater.string"
    p data_formater.data
    #   pass to sentiment
    # service sentiment
    sentiment = Sentiment.new(data_formater.data)
    sentiment.send
    p "/ "*10 + "sentiment.response"
    p sentiment.response
    #   send data to sentiment analysis
    #   format data for viewing (chartist)

    statistics = Statistics.new(sentiment.response)
    statistics.calculate

    statistics.results['query'] = params[:q]
    p statistics.results

    @statistics = statistics

    @chart_test = {
      'positive_average%' => @statistics.results['positive_average%'],
      'negative_average%' => @statistics.results['negative_average%'],
      'neutral_average%' => @statistics.results['neutral_average%']
    }

    # redirect_to(root_path, :notice => 'Feedback was successfully updated.')
		# render 'twitter/search.html.erb'
    # render statistics.results
    render 'twitter/search.html.erb'

  end
end





# still having issues with redirecting the front end to new page
# possible to just update the main page?
