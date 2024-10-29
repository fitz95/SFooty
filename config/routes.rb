namespace :api do
  namespace :v1 do
    # Devise routes
    devise_for :users, controllers: {
      sessions: 'api/v1/sessions',
      registrations: 'api/v1/registrations',
      passwords: 'api/v1/passwords'
    }

    # User routes
    resources :users do
      resources :leagues do
        # Include the update action here
        member do
          patch :update
        end
        
        resources :teams, only: [:index, :show, :create, :destroy] do 
          resources :players, only: [:index, :show, :create, :destroy]
          resources :trophies, only: [:index, :show, :create, :destroy]
          resources :stadiums, only: [:index, :show, :create, :destroy]
        end 
      end
      resources :posts, only: [:index, :show, :create, :destroy]
      resources :match_officials, only: [:index, :show, :create, :destroy]
      resources :player_transfers, only: [:index, :show, :create, :destroy]
      resources :player_injuries, only: [:index, :show, :create, :destroy]
    end
  end
end
