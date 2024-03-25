Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root to: redirect('/api-docs')
  apipie
  namespace :api do
    namespace :v1 do
      # Devise routes
      devise_for :users, controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations',
        passwords: 'api/v1/passwords'
      }
      # Registration route
      #other routes
      # User routes
      resources :users do
        resources :leagues, only: [:index, :show, :create, :destroy] do
          resources :teams, only: [:index, :show, :create, :destroy] do 
            resources :players, only: [:index, :show, :create, :destroy]
          end 
        end
        resources :match_officials, only: [:index, :show, :create, :destroy]
        resources :player_transfers, only: [:index, :show, :create, :destroy]
        resources :player_injuries, only: [:index, :show, :create, :destroy]
      end
    end
  end
end