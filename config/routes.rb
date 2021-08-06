Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  resources :articles do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: :show do
    member do
      get :followings
      get :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
end
