class TweetRetweetingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(5) }

  def perform
    tweet_id = REDIS.zrange(Searcher::RETWEETABLE_SET_KEY, 0, 0).first
    TWITTER.retweet tweet_id
    REDIS.zrem Searcher::RETWEETABLE_SET_KEY, tweet_id.to_s
    REDIS.zadd 'retweeted-tweets', Time.now.utc.to_i, tweet_id.to_s
  end

end
