Web2::Application.routes.draw do
  root to: "static#index"
  get "/api" => "static#api"
  devise_for :users
  resources :users do
    resources :keys
    resources :apps
  end
end
