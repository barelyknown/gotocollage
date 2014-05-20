class PulseTakingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def perform
    if Rails.env.production?
      HTTP.get 'http://gotocollage.herokuapp.com/pulse'
    end
  end

end
