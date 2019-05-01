Rails.application.routes.draw do
<<<<<<< HEAD
  resources :products, except: [:destroy]
  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"
=======
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, except: [:new]
  resources :products
>>>>>>> orders
end
