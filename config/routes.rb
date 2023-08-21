Rails.application.routes.draw do
  # Using Devise
  devise_for :users

  # Root
  root to: 'pages#home'

  # Created all 7 CRUD routes
  resources :products
end
