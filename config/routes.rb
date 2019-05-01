Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants


  # testing
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
end
