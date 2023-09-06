Rails.application.routes.draw do
  root 'public#index'

  resources :users do
    resources :reviews
  end

  post '/login' => 'public#login'
  get '/profile' => 'private#profile'
  get '*path' => 'public#not_found'
end
