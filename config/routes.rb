Rails.application.routes.draw do
  resources :services
  resources :users do
    # ========================================
    #   NESTED ROUTES FOR SUBSCRIPTIONS
    # ========================================
    get '/subscriptions/archive', to: 'subscriptions#archive', as: 'archive_subscriptions'
    delete '/subscriptions/:id/cancel', to: 'subscriptions#cancel', as: 'cancel_subscription'
    resources :subscriptions, only: %i[index show new create]
  end

  get '/signup', to: 'users#new'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  get '/dashboards', to: 'dashboards#index'
  get '/dashboards/:id', to: 'dashboards#show'

  root 'welcome#home'
end
