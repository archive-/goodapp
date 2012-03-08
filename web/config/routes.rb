Web::Application.routes.draw do
  root :to => 'static#home'

  get '/search' => 'static#search', :as => :search
  get '/about' => 'static#about', :as => :about
  get '/contact' => 'static#contact', :as => :contact
  get '/api' => 'static#api', :as => :api

  get '/register' => 'users#new', :as => :register
  get '/login' => 'sessions#new', :as => :login
  post '/login' => 'sessions#create', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout

  get '/users' => 'users#index', :as => :users
  get '/users/:id' => 'users#show', :as => :user
  get '/users/:id/edit' => 'users#edit', :as => :edit_user
  post '/users' => 'users#create', :as => :users

  post '/upgrade' => 'users#upgrade', :as => :upgrade
  post '/downgrade' => 'users#downgrade', :as => :downgrade

  get '/upload' => 'apps#new', :as => :upload
  post '/uploads' => 'apps#create', :as => :apps
  get '/apps' => 'apps#index', :as => :apps
  get '/apps/:id' => 'apps#show', :as => :app
  post '/apps/:id/flag' => 'apps#flag', :as => :app_flag
end
