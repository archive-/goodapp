Web2::Application.routes.draw do
  root to: "static#index"
  get "/api" => "static#api"
  get "/about" => "static#about", as: :about

  devise_for :users
  resources :users, except: [:edit, :update] do
    resources :keys
    resources :apps, except: [:new, :create]
  end
  get "/apps/:id/mini" => "apps#mini", as: :show_app_mini
  get "/settings" => "users#edit", as: :edit_user
  put "/settings" => "users#update", as: :users
  get "/upload" => "apps#new", as: :new_app
  post "/upload" => "apps#create", as: :apps
end
