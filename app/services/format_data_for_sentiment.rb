class FormatDataForSentiment
  attr_accessor :string, :data
  def initialize(data)
    @data = data
    # @string = ''
  end

  def perform
    @data = JSON.parse(@data)
    @data['statuses'].map! do |tweet|
      tweet['text']
      # @string += tweet['text'] + '\r'
    end
    @data = @data['statuses']
    # @string = 'text: ' + @string

  end
end
