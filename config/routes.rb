Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :users,only: [:show,:index,:edit,:update, :follows] do
   resources :relationships, only: [:create, :destroy]
   get 'relationships/followers' => 'relationships#followers', as: 'followers'
   get 'relationships/followings' => 'relationships#followings', as: 'followings'
  end
   resource :relationships, only: [:create, :destroy]
   
  resources :books do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  
  get 'home/about' => 'homes#about'
end