Web::Application.routes.draw do
  # TODO put in authorization so can't hit routes like /settings (obviously)
  constraints subdomain: "api" do
    get "/" => "static#api", as: :api
    get "/users/:id" => "users#show", format: :json
    get "/apps/:id" => "apps#show", format: :json
  end
  authenticated :user do
    root to: "static#dashboard"
  end
  root to: "static#index"
  mount Resque::Server.new, at: "/resque"
  get  "/about" => "static#about", as: :about
  get  "/faq" => "static#faq", as: :faq
  get  "/search" => "static#search", as: :search
  get  "/trust" => "static#trust", as: :trust
  get  "/contact" => "static#contact", as: :contact
  post "/contact" => "static#send_contact_email", as: :send_contact_email
  devise_for :users, controllers: {confirmations: "users/confirmations"}
  resources :users, except: [:edit, :update] do
    # TODO scope keys? so its "/keys/:id"
    resources :keys, except: [:new, :create]
    resources :apps, except: [:new, :create]
  end
  get "/apps/:id" => "apps#show", as: :app
  get "/keys/:id/confirm/:confirmation_token" => "keys#confirm", as: :key_confirmation
  get "/apps/:id/mini" => "apps#mini", as: :show_app_mini
  get "/keys/:id/mini" => "keys#mini", as: :show_key_mini
  get "/settings" => "users#edit", as: :setting
  put "/settings" => "users#update", as: :settings
  get "/upload/app" => "apps#new", as: :new_app
  post "/upload/app" => "apps#create", as: :apps
  post "/upload/key" => "keys#create", as: :keys
  post "/endorsements" => "endorsements#create", as: :endorsements
  post "/github-connect" => "users#github_connect", as: :github_connect
  put "/github-sync" => "users#github_sync", as: :github_sync
end
