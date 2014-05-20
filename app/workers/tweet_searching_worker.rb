class TweetSearchingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def perform
    remaining = 5

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
