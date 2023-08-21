Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Created all 7 CRUD routes
  resources :products
end
