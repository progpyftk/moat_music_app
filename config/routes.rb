# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  get '/signup', to: 'users#new' # signup_path = /signup
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'static_pages#home' # get 'static_pages/home'
  resources :users
  resources :albums
end
