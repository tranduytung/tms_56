Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  namespace :supervisor do
    root "static_pages#home"
    resources :courses, except: [:new]
    resources :courses, only: :show do
      resource :add_user_courses, only: [:edit, :update]
    end
    resources :user_courses, only: :destroy
    resources :users
    resources :subjects, only:[:index, :create]
  end
  
  resources :courses, only: [:show]
  resources :user_courses, only: [:index]

  resources :users, only: [:show]
  resources :relationships, only: [:create, :destroy, :show]
  resources :users, only: [:index] do 
    resources :relationships, only: [:index]
  end
end
