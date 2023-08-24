Rails.application.routes.draw do
  # Using Devise for users
  devise_for :users
  get '/profile', to: 'pages#profile', as: :profile

  # Root
  root to: 'pages#home'

  # Created all 7 CRUD routes for products
  resources :products
  get '/my-products', to: 'products#my_products'

  # Bookmark routes
  resources :bookmarks, only: %i[index create destroy]
end
