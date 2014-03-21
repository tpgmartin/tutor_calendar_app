PracticeApp::Application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :invitations
  resources :messages
  resources :activities
  resources :sessions
  resources :users do
    resources :comments
  end
  resources :events, module: 'user'
  resources :events do
    resources :comments
  end
  resources :relationships, module: 'user'
  resources :password_resets
  get '/contact_us', to: 'welcome#contact_us'
  root to: 'welcome#index'
end