GalleryApp::Application.routes.draw do
  #get "home/index"

  #get "comments/new"

  #get "bids/new"

  #get "artifacts/new"

  resources :users do
    collection do
      get :following, :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :artifacts do
    resources :comments, only: [:new, :create, :show ]
  end
  resources :bids, only: [:show, :update]
  resources :followings, only: [:create, :destroy]



  root to: 'home#index'
  #get "static_pages/home"

  #get "users/new"
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/mybid/:id', to: 'bids#update', via: :put

  match '/all_artifacts', to: 'artifacts#index', format: :xml
end
