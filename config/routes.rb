Rails.application.routes.draw do
  root 'home#index'

  resources :users

  post '/login' => 'users#login'
  get '*path' => 'home#not_found'
end
