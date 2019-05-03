Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#homepage"
  
  resources :orders, except: [:new, :show]
  get "/cart", to: "orders#current", as: "current_order"
  post "/cart", to: "orders#checkout", as: "checkout"
  get "/order-confirmation", to: "orders#confirmation", as: "order_confirmation"
  
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:create]
  end
  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"
  
  resources :categories do
    resources :products, only: [:index]
  end
  
  resources :categories, only: [:new, :create]

  resources :order_products, only: [:create, :destroy]

  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"

  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
  get "/auth/github", as: "github_login"
  delete "/logout", to: "merchants#destroy", as: "logout"
end
