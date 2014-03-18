PracticeApp::Application.routes.draw do


  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :sessions
  resources :users do
    resources :comments
  end
  resources :password_resets
  resources :relationships
  root to: 'events#index'
  resources :events do
    resources :comments
  end

end
