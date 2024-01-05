Rails.application.routes.draw do

  post '/registrations', to: 'registrations#create'
  patch '/users/:id/update', to: 'registrations#update'
  get '/users/search', to: 'registrations#search'

  get '/confirmation', to: 'confirmations#show'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/users/:user_id/projects', to: 'projects#create'
  get '/users/:user_id/projects', to: 'projects#index'

  post '/users/:user_id/projects/:project_id/issues', to: 'issues#create'
  get '/users/:user_id/projects/:project_id/issues', to: 'issues#index'
  get '/users/:user_id/projects/:project_id/issues/:issue_id', to: 'issues#show'

  devise_for :users
  # devise_scope :user do
  #   # Your Devise routes go her
  #   post '/users/sign_in' => 'sessions#create'
  # end
end
