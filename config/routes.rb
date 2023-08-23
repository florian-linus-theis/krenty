Rails.application.routes.draw do
  # Using Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # Root
  root to: 'pages#home'
  get '/profile', to: 'pages#profile', as: :profile

  # Created all 7 CRUD routes for products
  resources :products
  get '/my-products', to: 'products#my_products'
end
