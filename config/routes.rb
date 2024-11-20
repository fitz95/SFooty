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
        resources :leagues, only: [:index, :show, :create, :destroy, :update] 
        resources :players, only: [:index, :show, :create, :destroy, :update]
        resources :teams, only: [:index, :show, :create, :destroy, :update] 
        resources :trophies, only: [:index, :show, :create, :destroy, :update]
        resources :stadiums, only: [:index, :show, :create, :destroy, :update]
        resources :posts, only: [:index, :show, :create, :destroy, :update]
        resources :match_officials, only: [:index, :show, :create, :destroy, :update]
        resources :player_transfers, only: [:index, :show, :create, :destroy, :update]
        resources :player_injuries, only: [:index, :show, :create, :destroy, :update]
        resources :managers, only: [:index, :show, :create, :destroy, :update]
        resources :seasons, only: [:index, :show, :create, :destroy, :update]
        resources :season_managers, only: [:index, :show, :create, :destroy, :update]
        resources :game_weeks, only: [:index, :show, :create, :destroy, :update]
        resources :matches, only: [:index, :show, :create, :destroy, :update] do
          resources :substitutions, only: [:index, :show, :create, :destroy, :update]
          resources :match_shots, only: [:index, :show, :create, :destroy, :update] do
            collection do
              get :on_target
              get :missed_shots
              get :total_xg
            end
          end
          resources :match_goals, only: [:index, :show, :create, :destroy, :update]
          resources :match_blocks, only: [:index, :show, :create, :destroy, :update] do
            collection do
              get :blocked_shots
            end
          end
          resources :match_interceptions, only: [:index, :show, :create, :destroy, :update]
          resources :match_passes, only: [:index, :show, :create, :destroy, :update] do
            collection do
              get :key_passes
              get :completed_passes
              get :chances_created
              get :total_xg
            end
          end
          resources :match_touches, only: [:index, :show, :create, :destroy, :update] do
            collection do
              get :touches  
              get :in_box
            end
          end
          resources :match_dribbles, only: [:index, :show, :create, :destroy, :update]
        end
        resources :competitions, only: [:index, :show, :create, :destroy, :update]
        resources :formations, only: [:index, :show, :create, :destroy, :update] do
          resources:formation_positions, only: [:index, :show, :create, :destroy, :update]
        end
        resources :match_lineups, only: [:index, :show, :create, :destroy, :update]

      end
    end
  end
end

