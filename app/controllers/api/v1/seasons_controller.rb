class Api::V1::SeasonsController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_season, only: %i[show update destroy]
  
    # API Documentation for getting all seasons for a user
    api :GET, '/v1/users/:user_id/seasons', 'Get all seasons for the user'
    def index
      @seasons = @user.seasons
      render json: @seasons
    end
  
    # API Documentation for getting a specific season by ID
    api :GET, '/v1/users/:user_id/seasons/:id', 'Get season with id'
    param :id, :number, desc: 'ID of the requested season', required: true
    error code: 404, desc: 'Season not found!'
    def show
      render json: @season
    end
  
    # API Documentation for creating a new season
    api :POST, '/v1/users/:user_id/seasons', 'Create a new season for this user'
    def create
      @season = @user.seasons.new(season_params)
  
      if @season.save
        render json: @season, status: :created, message: 'Season was successfully created.'
      else
        render json: @season.errors, status: :unprocessable_entity
      end
    end
  
    # API Documentation for updating a specific season
    api :PATCH, '/v1/users/:user_id/seasons/:id', 'Update season with id'
    def update
      if @season.update(season_params)
        render json: @season, message: 'Season was successfully updated.'
      else
        render json: @season.errors, status: :unprocessable_entity
      end
    end
  
    # API Documentation for deleting a season by ID
    api :DELETE, '/v1/users/:user_id/seasons/:id', 'Delete season by id'
    def destroy
      authorize! :destroy, Season
      if @season.destroy
        render json: { message: 'Season deleted successfully!' }, status: :ok
      else
        render json: { error: 'Failed to delete the Season.' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_season
      @season = @user.seasons.find(params[:id])
    end
  
    def season_params
      params.require(:season).permit(:name, :start_date, :end_date, :status, :number_of_teams, :season_type, :description, :total_matches, :user_id)
    end
  end
  