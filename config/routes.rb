GalleryApp::Application.routes.draw do
  resources :users
  root to: 'static_pages#home'
  #get "static_pages/home"

  #get "users/new"
  match '/signup', to: 'users#new'
end
