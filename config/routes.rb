Rails.application.routes.draw do
  root to: 'toppages#index'

 get 'login', to: 'sessions#new'
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'

 get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
   member do 
       get :followings
       get :followers
    end  
   end

  resources :schedules, only: [:index, :new, :show, :create,:destroy]
  resources :relationships, only: [:new, :show, :create, :destroy]
end  

