Rails.application.routes.draw do
  resources :products
  get 'products/index'
  devise_for :users
  root to: 'pages#home'
end
