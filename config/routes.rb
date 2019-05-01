Rails.application.routes.draw do
  resources :products, except: [:destroy]
  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"
end
