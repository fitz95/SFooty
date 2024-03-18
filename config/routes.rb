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
        resources :leagues do
        resources :teams
        end 
      end
    end
  end
end