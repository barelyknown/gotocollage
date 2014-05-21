Sidekiq.configure_client do |config|
  config.redis = { :size => 1, :url => ENV['REDIS_URL'], :namespace => "gotocollage_#{Rails.env}" }
end
Sidekiq.configure_server do |config|
  config.redis = { :size => 1, :url => ENV['REDIS_URL'], :namespace => "gotocollage_#{Rails.env}" }
end
