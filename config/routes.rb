Rails.application.routes.draw do
  root 'home#index'

  resources :users

  get '*path' => 'home#not_found'
end
