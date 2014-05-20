class TweetSearchingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def perform
    maximum = Searcher::MAX_PER_FIFTEEN_MINUTES - 40 #buffer
    now = Time.now.utc.to_i
    fifteen_minutes_ago = Time.now.utc.advance(minutes: -15).to_i
    recent = REDIS.zrangebyscore(Searcher::SEARCHES_SET_KEY, fifteen_minutes_ago, now).size
    remaining = maximum - recent

    while remaining > 0
      remaining -= 1
      latest = REDIS.zrange(Searcher::PROCESSED_SET_KEY, -1, -1).first
      break if Searcher.new(since_id: latest).search == 0
    end

    while remaining > 0
      remaining -= 1
      earliest = REDIS.zrange(Searcher::PROCESSED_SET_KEY, 0, 0).first
      break if Searcher.new(max_id: earliest).search == 0
    end

  end

end
