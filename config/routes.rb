Rails.application.routes.draw do
  devise_for :users
  resources :payments
  resources :bookings
  resources :sports_fields
  resources :users

  get "/login", to: "authenticate#login"
  # get "/register", to: "authenticate#register"

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#login"

end
