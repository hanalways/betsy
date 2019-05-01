Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD
  resources :merchants

  resources :products, except: [:destroy]
  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"

  resources :orders, except: [:new]
=======
  resources :merchants #, only: [:index, :show]
  resources :products

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create"
  delete "/logout", to: "merchants#destroy", as: "logout"
>>>>>>> hlc/oauth-install
end
