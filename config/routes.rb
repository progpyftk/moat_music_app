Rails.application.routes.draw do
  get '/signup', to: 'users#new' # signup_path = /signup
  get 'static_pages/home'
end
