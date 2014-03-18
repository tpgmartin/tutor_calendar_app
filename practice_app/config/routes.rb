PracticeApp::Application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :sessions
  resources :users do
    resources :events
  end
  resources :comments
  resources :password_resets
  resources :relationships
  resources :events
  root to: 'welcome#index'
end