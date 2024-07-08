Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admin_users, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }
  
  namespace :admin do
    root to: 'dash_board#index'
    resources :orders
    resources :products
  end
  # normal_user_routes

  devise_for :users 
  resources :users, only: [:show, :edit, :update]
  root "home#index"
  resources :home do
    collection do
      get :privacy_policy
      get :terms_conditions
      get :shipping_policy
      get :return_policy
      get :cancellation_policy
    end
  end
  resources :replies
  resources :questions
  resources :reviews
  resources :addresses
  resources :payments do
    member do
      post :payment_success
    end
  end
  resources :cart_items
  resources :carts do 
    member do
      get :checkout, as: :checkout_process
    end
  end
  resources :order_items
  resources :orders
  resources :products
  resources :categories
end
