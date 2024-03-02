Rails.application.routes.draw do
  resources :follow_requests
  resources :comments
  resources :photos
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "photos#index"  
  # Defines the root path route ("/")
  # root "articles#index"
end
