Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  resources :articles
  resources :users, only: :show do
    member do
      get :followings
      get :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
