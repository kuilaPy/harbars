Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admin_users, path: 'admin', controllers: {
    sessions: 'admin_users/sessions',
    registrations: 'admin_users/registrations'
  }
  
  namespace :admin do
    root to: 'dash_board#index'
    resources :orders
    resources :products
  end
  # normal_user_routes

  devise_for :users
  root "home#index"
  resources :replies
  resources :questions
  resources :reviews
  resources :addresses
  resources :payments
  resources :cart_items
  resources :carts
  resources :order_items
  resources :orders
  resources :products
  resources :categories
end
