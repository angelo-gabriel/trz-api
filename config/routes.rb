Rails.application.routes.draw do
  resources :items
  resources :inventories
  resources :survivors do
    member do
      patch 'update_location', to: 'survivors#update_location'
      get 'items'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post 'trade_items', to: 'trades#perform_trade'
end
