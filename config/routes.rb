Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # devise_for :users
  # root to: 'homes#top'
  # get 'home/about' => 'homes#about', as: 'about'

  # resources :posts, only: [:new, :create, :index, :show, :destroy] do
  #   resources :post_comments, only: [:create, :destroy]
  #   resource :bookmarks, only: [:create, :destroy]
  # end
  # resources :users, only: [:index, :show, :edit, :update]

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :destroy]
    resources :posts, only: [:index, :destroy]
  end

  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get 'home/about' => 'homes#about', as: 'about'
    get 'search' => 'searches#search', as: 'search'
    get 'post/bookmarked_index' => 'posts#bookmarked_index', as: 'bookmarked'
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :bookmark, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end
end
