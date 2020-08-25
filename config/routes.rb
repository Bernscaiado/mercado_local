Rails.application.routes.draw do
  resources :carts, only: %i[index edit update destroy]
  resources :products do
    resources :carts, only: %i[new create]
  end
  get 'products/index'
  devise_for :users
  root to: 'pages#home'
end
