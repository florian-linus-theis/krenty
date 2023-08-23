Rails.application.routes.draw do
  # Using Devise
  devise_for :users

  # Root
  root to: 'pages#home'
  get '/profile', to: 'pages#profile', as: :profile

  # Created all 7 CRUD routes for products
  resources :products
  get 'products/my', to: 'products#my_products'
end
