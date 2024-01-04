Rails.application.routes.draw do

  post '/registrations', to: 'registrations#create'
  patch '/users/:id/update', to: 'registrations#update'
  get '/confirmation', to: 'confirmations#show'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/users/:user_id/projects', to: 'projects#create'

  devise_for :users
  # devise_scope :user do
  #   # Your Devise routes go her
  #   post '/users/sign_in' => 'sessions#create'
  # end
end
