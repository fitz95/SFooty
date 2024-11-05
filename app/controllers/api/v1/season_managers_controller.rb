class Api::V1::SeasonManagersController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_season_manager, only: %i[show update destroy]
  
    # API Documentation for getting all season managers for a user
    api :GET, '/v1/users/:user_id/season_managers', 'Get all season managers for the user'
    def index
      @season_managers = @user.season_managers
      render json: @season_managers
    end
  
    # API Documentation for getting a specific season manager by ID
    api :GET, '/v1/users/:user_id/season_managers/:id', 'Get season manager with id'
    param :id, :number, desc: 'ID of the requested season manager', required: true
    error code: 404, desc: 'Season Manager not found!'
    def show
      render json: @season_manager
    end
  
    # API Documentation for creating a new season manager
    api :POST, '/v1/users/:user_id/season_managers', 'Create a new season manager for this user'
    def create
      @season_manager = @user.season_managers.new(season_manager_params)
  
      if @season_manager.save
        render json: @season_manager, status: :created, message: 'Season Manager was successfully created.'
      else
        render json: @season_manager.errors, status: :unprocessable_entity
      end
    end
  
    # API Documentation for updating a specific season manager
    api :PATCH, '/v1/users/:user_id/season_managers/:id', 'Update season manager with id'
    def update
      if @season_manager.update(season_manager_params)
        render json: @season_manager, message: 'Season Manager was successfully updated.'
      else
        render json: @season_manager.errors, status: :unprocessable_entity
      end
    end
  
    # API Documentation for deleting a season manager by ID
    api :DELETE, '/v1/users/:user_id/season_managers/:id', 'Delete season manager by id'
    def destroy
      authorize! :destroy, SeasonManager
      if @season_manager.destroy
        render json: { message: 'Season Manager deleted successfully!' }, status: :ok
      else
        render json: { error: 'Failed to delete the Season Manager.' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_season_manager
      @season_manager = @user.season_managers.find(params[:id])
    end
  
    def season_manager_params
      params.require(:season_manager).permit(:role, :performance_rating, :season_start_date, :season_end_date, :goals, :bonuses, :contract_terms, :status, :team_performance_notes, :training_style, :most_used_formation, :most_improved_player, :relegated, :promoted, :season_id, :manager_id, :team_id, :user_id)
    end
  end
  