class TweetRetweetingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(5) }

  def perform
    retweeted, no_more_tweets = false, false
    until retweeted || no_more_tweets
      tweet_id = REDIS.zrange(Searcher::RETWEETABLE_SET_KEY, 0, 0).first
      if tweet_id.present?
        tweet = TWITTER.status(tweet_id)
        unless Filter.new(tweet).filter?
          TWITTER.retweet tweet_id
          REDIS.zadd 'retweeted-tweets', Time.now.utc.to_i, tweet_id.to_s
          retweeted = true
        end
        REDIS.zrem Searcher::RETWEETABLE_SET_KEY, tweet_id.to_s
      else
        no_more_tweets = true
      end
    end
  rescue Twitter::Error::NotFound
  end

end
