GalleryApp::Application.routes.draw do
  #get "artifacts/new"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :artifacts

  root to: 'static_pages#home'
  #get "static_pages/home"

  #get "users/new"
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
end
