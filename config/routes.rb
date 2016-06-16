Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  namespace :supervisor do
    root "static_pages#home"
    resources :users, only: [:index]
  end
  
  resources :courses, only: [:show]
  resources :user_courses, only: [:index]
end
