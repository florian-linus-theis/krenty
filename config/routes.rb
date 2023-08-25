Rails.application.routes.draw do
  # Using Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get '/profile', to: 'pages#profile', as: :profile

  # Root
  root to: 'pages#home'

  # Created all 7 CRUD routes for products
  get '/my-products', to: 'products#my_products'

  # Products and Pruchases routes
  resources :products do
   resources :purchases, only: [:create]
  end
  resources :purchases, only: [:index, :destroy]
  delete '/empty-basket', to: 'purchases#destroy_all_purchases', as: :destroy_all_purchases

  # Bookmark routes
  resources :bookmarks, only: %i[create destroy]
  get '/my-favorites', to: 'bookmarks#index'
end
