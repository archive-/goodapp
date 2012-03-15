Web::Application.routes.draw do
  root :to => 'static#home'

  get '/search' => 'static#search', :as => :search
  get '/about' => 'static#about', :as => :about
  get '/contact' => 'static#contact', :as => :contact
  post '/contact' => 'static#send_contact_mail', :as => :send_contact_mail
  get '/api' => 'static#api', :as => :api

  get '/register' => 'users#new', :as => :register
  get '/login' => 'sessions#new', :as => :login
  post '/login' => 'sessions#create', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout

  get '/users' => 'users#index', :as => :users
  get '/users/:id' => 'users#show', :as => :user
  get '/users/:id/edit' => 'users#edit', :as => :edit_user
  put '/users/:id' => 'users#update', :as => :user
  post '/users' => 'users#create', :as => :users

  post '/upgrade' => 'users#upgrade', :as => :upgrade
  post '/downgrade' => 'users#downgrade', :as => :downgrade

  get '/upload' => 'apps#new', :as => :upload
  get '/apps' => 'apps#index', :as => :apps
  post '/apps' => 'apps#create', :as => :apps
  get '/apps/:id' => 'apps#show', :as => :app
  post '/apps/:id/flag' => 'apps#flag', :as => :app_flag

  post '/endorsements' => 'endorsements#create', :as => :endorsements
  # TODO POST to would be nicer, imo, 'apps/:id/feedback'
  post 'apps/:app_id/submit_feedback', :to => 'basic_feedbacks#create'

  # TODO add individual resource routes for basic_feedbacks (otherwise broken)
  resource :basic_feedbacks
end
