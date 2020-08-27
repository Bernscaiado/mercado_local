Rails.application.routes.draw do
  resources :carts, only: %i[index edit update destroy]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end
  resources :products do
    resources :carts, only: %i[new create]
  end
  get 'products/index'
  devise_for :users
  get 'category', to: 'pages#category', as: 'category'
  get 'search', to: 'pages#search'
  get 'myprofile', to: 'pages#profile'
  get 'producers', to: 'pages#producer'
  root to: 'pages#home'
end
