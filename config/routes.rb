Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  get 'pulse', to: 'pulse#index', as: :pulse

end
