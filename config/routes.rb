Rails.application.routes.draw do
<<<<<<< HEAD
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, except: [:new]
  resources :products
=======

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants

  resources :products, except: [:destroy]
  post "product/:id/toggle_retire", to: "products#toggle_retire", as: "toggle_retire_product"

  resources :orders, except: [:new]
>>>>>>> f5cd0262171ed54d90fcc923350ccd0fcaeaa6d3
end
