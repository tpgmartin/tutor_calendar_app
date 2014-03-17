PracticeApp::Application.routes.draw do


  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :sessions
  resources :users, :has_many => :comments
  resources :password_resets
  resources :relationships
  root to: 'events#index'
  resources :events, :has_many => :comments

end
