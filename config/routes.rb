Rails.application.routes.draw do
  get '/confirmation', to: 'confirmations#show'
  post '/registrations', to: 'registrations#create'

  devise_for :users
  devise_scope :user do
    # Your Devise routes go her
    post '/users/sign_in' => 'sessions#create'
  end
end
