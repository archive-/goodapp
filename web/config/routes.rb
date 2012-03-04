Web::Application.routes.draw do
  root :to => 'static#home'

  get '/search' => 'static#search', :as => :search
  get '/about' => 'static#about', :as => :about
  get '/contact' => 'static#contact', :as => :contact

  get '/register' => 'devs#new', :as => :register
  get '/login' => 'sessions#new', :as => :login
  post '/login' => 'sessions#create', :as => :login
  post '/logout' => 'sessions#destroy', :as => :logout

  get '/devs' => 'devs#index', :as => :devs
  get '/devs/:id' => 'devs#show', :as => :dev

  get '/apps' => 'apps#index', :as => :apps
  get '/apps/:id' => 'apps#show', :as => :app
  post '/apps/:id/flag' => 'apps#flag', :as => :app_flag
end
