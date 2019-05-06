Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#homepage"

  resources :orders, except: [:new]
  get "/cart/:id", to: "orders#current", as: "current_order"
  post "/cart/:id", to: "orders#checkout", as: "checkout"
  get "/order-confirmation/:id", to: "orders#confirmation", as: "order_confirmation"

  resources :products, only: [:index, :show] do
    resources :reviews, only: [:create]
  end
  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"

  resources :categories do
    resources :products, only: [:index]
  end

  resources :categories, only: [:new, :create]

  resources :order_products, only: [:create, :update, :destroy]

  resources :merchants, only: [:index, :show] do
    resources :products
  end
  get "/merchant_dashboard", to: "merchants#current", as: "dashboard"
  get "/merchant_orders", to: "merchants#orders", as: "merchant_orders"

  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
  get "/auth/github", as: "github_login"
  delete "/logout", to: "merchants#destroy", as: "logout"
end
