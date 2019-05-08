Rails.application.routes.draw do
  resources :users
  resources :services
  resources :subscriptions

  get '/signup', to: 'users#new'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  root 'welcome#home'
end
