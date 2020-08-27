Rails.application.routes.draw do
  resources :producers, only: %i[new create index show]
  resources :carts, only: %i[index edit update destroy]
  resources :products do
    resources :carts, only: %i[new create]
  end
  get 'products/index'
  devise_for :users
  get 'category', to: 'pages#category', as: 'category'
  get 'search', to: 'pages#search'
  get 'myprofile', to: 'pages#profile'
  root to: 'pages#home'
end
