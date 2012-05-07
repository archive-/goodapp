Web::Application.routes.draw do
  devise_for :users,
  path_names: {
    sign_in: "login", sign_out: "logout", registration: "register"
  }
  devise_scope :user do
    get    "/register" => "devise/registrations#new", as: :register
    get    "/login"    => "devise/sessions#new"
    post   "/login"    => "devise/sessions#create"
    # post "/login"   => "sessions#create", as: :login
    delete "/logout"   => "devise/sessions#destroy", as: :logout
  end
  resources :users
  root   to: "static#home"
  get    "/autosearch" => "static#autosearch", as: :autosearch
  get    "/search" => "static#search", as: :search
  get    "/about" => "static#about", as: :about
  get    "/contact" => "static#contact", as: :contact
  post   "/contact" => "static#send_contact_mail", as: :send_contact_mail
  get    "/api" => "static#api", as: :api
  get    "/faq" => "static#faq", as: :faq
  post   "/upgrade" => "users#upgrade", as: :upgrade
  post   "/downgrade" => "users#downgrade", as: :downgrade
  get    "/upload" => "apps#new", as: :upload
  get    "/apps" => "apps#index", as: :apps
  post   "/apps" => "apps#create", as: :apps
  get    "/apps/:id" => "apps#show", as: :app
  post   "/apps/:id/flag" => "apps#flag", as: :app_flag
  post   "/endorsements" => "endorsements#create", as: :endorsements
  # TODO POST to would be nicer, imo, "apps/:id/feedback"
  post   "/basic_feedbacks" => "basic_feedbacks#create", as: :basic_feedbacks
  put    "/basic_feedbacks.:id" => "basic_feedbacks#update", as: :basic_feedback
end
