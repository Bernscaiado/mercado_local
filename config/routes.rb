Rails.application.routes.draw do
  resources :products, only: %i[index show new create]
  get 'products/index'
  devise_for :users
  root to: 'pages#home'
end
