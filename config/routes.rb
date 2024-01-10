Rails.application.routes.draw do

  post '/registrations', to: 'registrations#create'
  patch '/users/:id/update', to: 'registrations#update'
  get '/users/search', to: 'registrations#search'
  get 'users/:user_id', to: 'registrations#show'

  get '/confirmation', to: 'confirmations#show'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/users/:user_id/projects', to: 'projects#create'
  get '/users/:user_id/projects', to: 'projects#index'
  post '/users/:user_id/projects/:project_id/addContributor', to: 'projects#addContributor'
  post '/users/:user_id/projects/:project_id/removeContributor', to: 'projects#removeContributor'
  get '/users/:user_id/projects/:project_id/fetchContributors', to: 'projects#fetchContributors'
  get '/users/:user_id/projects/:project_id/info', to: 'projects#info'

  post '/users/:user_id/projects/:project_id/issues', to: 'issues#create'
  get '/users/:user_id/projects/:project_id/issues', to: 'issues#index'
  get '/users/:user_id/projects/:project_id/issues/:issue_id', to: 'issues#show'
  patch '/users/:user_id/projects/:project_id/issues/:issue_id/resolve', to: 'issues#resolve'
  patch '/users/:user_id/projects/:project_id/issues/:issue_id/update', to: 'issues#update'

  post '/users/:user_id/projects/:project_id/wikis', to: 'wikis#create'
  get '/users/:user_id/projects/:project_id/wikis', to: 'wikis#index'
  get '/users/:user_id/projects/:project_id/wikis/:wiki_id', to: 'wikis#show'
  patch '/users/:user_id/projects/:project_id/wikis/:wiki_id/update', to: 'wikis#update'

  post '/users/:user_id/projects/:project_id/news', to: 'news#create'
  get '/users/:user_id/projects/:project_id/news', to: 'news#index'
  get '/users/:user_id/projects/:project_id/news/:news_id', to: 'news#show'
  patch '/users/:user_id/projects/:project_id/news/:news_id/update', to: 'news#update'

  post '/users/:user_id/projects/:project_id/news/:news_id/comments', to: 'comments#create'
  get '/users/:user_id/projects/:project_id/news/:news_id/comments', to: 'comments#index'

  devise_for :users
  # devise_scope :user do
  #   # Your Devise routes go here
  #   post '/users/sign_in' => 'sessions#create'
  # end
end
