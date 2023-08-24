Rails.application.routes.draw do
  # Using Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get '/profile', to: 'pages#profile', as: :profile

  # Root
  root to: 'pages#home'

  # Created all 7 CRUD routes for products
  resources :products
  get '/my-products', to: 'products#my_products'

  # Bookmark routes
  resources :bookmarks, only: %i[index create destroy]
end
