Rails.application.routes.draw do
  get '/services/stats', to: 'dashboards#services_stats'
  resources :services

  resources :users do
    # ========================================
    #   NESTED ROUTES FOR SUBSCRIPTIONS
    # ========================================
    get '/subscriptions/archive', to: 'subscriptions#archive', as: 'archive_subscriptions'
    delete '/subscriptions/:id/cancel', to: 'subscriptions#cancel', as: 'cancel_subscription'

    resources :subscriptions, only: %i[index show new create]

    # PERSONAL DASHBOARD
    get '/stats', to: 'dashboards#user_stats'
  end

  get '/signup', to: 'users#new'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  # ========================================
  #    DASHBOARD
  # ========================================
  get '/dashboard', to: 'dashboards#index'

  # HOME
  root 'welcome#home'
end
