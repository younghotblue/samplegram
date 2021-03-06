Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/post/hashtag/:name' => 'posts#hashtag'
  get    '/post/hashtag'       => 'posts#hashtag'
  get    '/signup',            to: 'users#new'
  get    '/login',             to: 'sessions#new'
  post   '/login',             to: 'sessions#create'
  delete '/logout',            to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts,               only: [:new, :create, :destroy, :show] do
    resources :likes,             only: [:create, :destroy]
    resources :comments,          only: [:create, :destroy]
  end
  resources :relationships,       only: [:create, :destroy]
  resources :notifications,       only: [:index, :destroy]
end
