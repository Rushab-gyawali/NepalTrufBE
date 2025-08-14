Rails.application.routes.draw do
  devise_for :users,
      controllers:{
        sessions:'users/sessions'
      }
  resources :payments
  resources :bookings
  resources :sports_fields

  post "/login", to: "authenticate#login"

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#login"

end
