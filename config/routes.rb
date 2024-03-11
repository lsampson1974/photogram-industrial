Rails.application.routes.draw do
  
  root "photos#index" 
  
  get "/:username" => "users#show", as: :user
  
  resources :likes
  resources :follow_requests
  resources :comments
  resources :photos
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
   
  # Defines the root path route ("/")
  # root "articles#index"
  
end
