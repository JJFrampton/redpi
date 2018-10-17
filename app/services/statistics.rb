class Statistics

	attr_accessor :results

  def initialize(data)
		puts "statistics has been initialized"
		@results = {
			'positive' => 0,
			'negative' => 0,
			'neutral' => 0,
			'positive%' => 0,
			'negative%' => 0,
			'neutral%' => 0,
			'total_data_points' => 0
		}
		@data = data
  end

  def calculate
		@data.each do | point |
			begin
			  point = JSON.parse(point)
				puts "point / / /"
				puts point['pos'].to_i
				puts point['neg'].to_i
				puts point['mid'].to_i
				@results['positive'] += point['pos'].to_i
				@results['negative'] += point['neg'].to_i
				@results['neutral'] += point['mid'].to_i
				@results['positive%'] += point['pos_percent'].to_i
				@results['negative%'] += point['neg_percent'].to_i
				@results['neutral%'] += point['mid_percent'].to_i
				@results['total_data_points'] += 1
			rescue StandardError => ex
				p ex
			end
		end
		# totals
		@results['positive_average'] = @results['positive'].to_f / @results['total_data_points'].to_f
		@results['negative_average'] = @results['negative'].to_f / @results['total_data_points'].to_f
		@results['neutral_average'] = @results['neutral'].to_f / @results['total_data_points'].to_f
		@results['positive_average%'] = @results['positive%'].to_f / @results['total_data_points'].to_f
		@results['negative_average%'] = @results['negative%'].to_f / @results['total_data_points'].to_f
		@results['neutral_average%'] = @results['neutral%'].to_f / @results['total_data_points'].to_f
  end
end
