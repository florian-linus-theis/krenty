Rails.application.routes.draw do
  # Using Devise
  devise_for :users

  # Root
  root to: 'pages#home'
  get '/profile', to: 'pages#profile', as: :profile

  # Created all 7 CRUD routes for products
  get '/my-products', to: 'products#my_products'

  resources :products do
   resources :purchases, only: [:create, :destroy]
  end

  resources :purchases, only: [:index]
end
