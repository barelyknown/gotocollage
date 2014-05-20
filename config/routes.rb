Rails.application.routes.draw do

  get 'pulse', to: 'pulse#index', as: :pulse

end
