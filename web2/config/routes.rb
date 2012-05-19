Web2::Application.routes.draw do
  root to: "static#index"
  devise_for :users
  resources :users do
    resources :keys
    resources :apps
  end
end
