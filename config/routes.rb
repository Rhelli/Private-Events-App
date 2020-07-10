Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  #get 'events/new', to: 'events#new'
  #post 'events/create', to: 'events#create'
  
  resources :users
  resources :events
  resources :users
  resources :invitations
end
