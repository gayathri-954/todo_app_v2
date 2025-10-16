Rails.application.routes.draw do
  # Mount Devise Token Auth routes for user registration & login
  mount_devise_token_auth_for 'User', at: 'auth'

  # Todo routes
  resources :todos

  # Default route (optional)
  root to: "todos#index"
end
