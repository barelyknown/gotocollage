source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '4.1.1'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'unicorn'
gem 'sidekiq'
gem 'twitter'
gem 'http'

# waiting for new version to be released for this patch
# https://github.com/tobiassvn/sidetiq/pull/80
gem 'sidetiq', github: 'tobiassvn/sidetiq'

gem 'dotenv-rails'

group :development do
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails', github: 'rspec/rspec-rails'
  gem 'spring-commands-rspec'
end

group :production do
  gem 'rails_12factor'
end
