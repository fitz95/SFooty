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
        resources :leagues, only: [:index, :show, :create, :destroy, :update] do
          resources :teams, only: [:index, :show, :create, :destroy, :update] do 
            resources :players, only: [:index, :show, :create, :destroy, :update]
            resources :trophies, only: [:index, :show, :create, :destroy, :update]
            resources :stadiums, only: [:index, :show, :create, :destroy, :update]
          end 
        end
        resources :posts, only: [:index, :show, :create, :destroy, :update]
        resources :match_officials, only: [:index, :show, :create, :destroy, :update]
        resources :player_transfers, only: [:index, :show, :create, :destroy, :update]
        resources :player_injuries, only: [:index, :show, :create, :destroy, :update]
      end
    end
  end
end