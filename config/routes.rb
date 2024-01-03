Rails.application.routes.draw do
  get 'sessions/new'
  get '/confirmation', to: 'confirmations#show'
  post '/registrations', to: 'registrations#create'
  patch '/users/:id/edit', to: 'registrations#update'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  devise_for :users
  # devise_scope :user do
  #   # Your Devise routes go her
  #   post '/users/sign_in' => 'sessions#create'
  # end
end
