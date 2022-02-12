Rails.application.routes.draw do
  get '/signup', to: 'users#new' # signup_path = /signup
  root 'static_pages#home' # get 'static_pages/home'
  resources :users
  
end
