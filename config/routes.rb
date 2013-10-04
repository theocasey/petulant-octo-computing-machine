Koffee::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products do
    resource :basket
  end

  resource :session
  get "/auth/:provider/callback", to: "sessions#create"
  get "/about", to: "content#about"

  resources :orders

  root "products#index"


end