Web::Application.routes.draw do
  root :to => 'static#home'
  resources :devs
end
