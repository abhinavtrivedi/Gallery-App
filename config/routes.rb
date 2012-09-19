GalleryApp::Application.routes.draw do
  #get "bids/new"

  #get "artifacts/new"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :artifacts
  resources :bids, only: [:new, :show, :edit, :update]

  root to: 'static_pages#home'
  #get "static_pages/home"

  #get "users/new"
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/mybid/:id', to: 'bids#update', via: :put
end
