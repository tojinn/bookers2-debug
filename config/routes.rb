Rails.application.routes.draw do
  get 'chats/show'
  devise_for :users
  root to: 'homes#top'
  resources :users,only: [:show,:index,:edit,:update] do
      get  "search", to: "users#search"
    member do
     get :follows, :followers
  end
    collection do
     get 'search'
    end
   resource :relationships, only: [:create, :destroy]
   get 'relationships/followers' => 'relationships#followers', as: 'followers'
   get 'relationships/followings' => 'relationships#followings', as: 'followings'
  end
   resource :relationships, only: [:create, :destroy]
   
  resources :books do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  
  resources :groups do
   get "join" => "groups#join"
   get "new/mail" => "groups#new_mail"
   get "send/mail" => "groups#send_mail"
  end
  
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'
  
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
end