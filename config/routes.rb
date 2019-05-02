Rails.application.routes.draw do
  root "merchants#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"

  resources :merchants, only: [:index, :show]
  resources :orders, except: [:new]
  resources :products, except: [:destroy]

  resources :order_products, only: [:create, :destroy]

  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"

  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
  get "/auth/github", as: "github_login"
  delete "/logout", to: "merchants#destroy", as: "logout"
end
