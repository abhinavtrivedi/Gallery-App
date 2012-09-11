GalleryApp::Application.routes.draw do
  get "users/new"
  match '/signup', to: 'users#new'
end
