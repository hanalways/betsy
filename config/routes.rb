Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants

  resources :products, except: [:destroy]
  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"

  resources :orders, except: [:new]
end
