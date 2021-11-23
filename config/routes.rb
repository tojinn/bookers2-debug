Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
   resource :favorites, only: [:create, :destroy]
   resource :book_comments, only: [:create, :destroy]
 end
  get 'home/about' => 'homes#about'
end