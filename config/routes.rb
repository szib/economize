Rails.application.routes.draw do
  resources :users
  get '/signup', to: 'users#new'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout',to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  root 'welcome#home'
end
