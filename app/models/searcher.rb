class Searcher
  QUERY = 'go to collage'
  PROCESSED_SET_KEY = 'processed-tweets'
  RETWEETABLE_SET_KEY = 'retweetable-tweets'
  MAX_PER_FIFTEEN_MINUTES = 180

  attr_reader :options

  def initialize(options)
    @options = { result_type: 'recent' }.merge(options)
  end

  def search
    results = TWITTER.search(QUERY, options)
    return 0 if results.count == 0
    results.each do |tweet|
      REDIS.zadd(PROCESSED_SET_KEY, tweet.id.to_i, tweet.id.to_s)
      unless Filter.new(tweet).filter?
        REDIS.zadd(RETWEETABLE_SET_KEY, tweet.id.to_i, tweet.id.to_s)
      end
    end
    results.count
  end

end
