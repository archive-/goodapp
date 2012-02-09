Web::Application.routes.draw do
  root :to => 'static#home'

  get '/register' => 'devs#new', :as => :register
  get '/login' => 'sessions#new', :as => :login
  post '/login' => 'sessions#create', :as => :login
  post '/logout' => 'sessions#destroy', :as => :logout

  resources :devs
  resources :apps do
    post :flag
  end
end
