Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
end
