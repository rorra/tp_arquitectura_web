Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # User authentication routes
  devise_for :users

  # Admin authentication routes
  devise_for :admin_users, path: "admin_users"

  # Home page
  root "pages#home"

  # App Routes below
  resources :products, only: [:index, :show]

  resource :cart, only: [:show] do
    post "add_item/:product_id", to: "carts#add_item", as: :add_item
    delete "remove_item/:product_id", to: "carts#remove_item", as: :remove_item
    get "checkout", to: "carts#checkout", as: :checkout
  end

  authenticate :user do
    resources :orders, only: [:index, :show, :create]
  end
end
