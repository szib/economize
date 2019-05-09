Rails.application.routes.draw do
  resources :users
  resources :services

  get '/subscriptions/archive', to: 'subscriptions#archive', as: 'archive_subscriptions'
  resources :subscriptions

  get '/signup', to: 'users#new'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  root 'welcome#home'
  delete '/subscriptions/:id/cancel', to: 'subscriptions#cancel', as: 'cancel_subscription'
end
