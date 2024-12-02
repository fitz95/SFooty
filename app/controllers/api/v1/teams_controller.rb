class Api::V1::TeamsController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_team, only: %i[show edit update destroy]
  
    # API Documentation for getting all teams for a user
    api :GET, '/v1/users/:user_id/teams', 'Get all teams for the user'
    def index
      @teams = @user.teams
      render json: @teams
    end
  
    # API Documentation for getting a specific team by ID
    api :GET, '/v1/users/:user_id/teams/:id', 'Get team with id'
    param :id, :number, desc: 'id of the requested team', required: true
    error code: 404, desc: 'Team not found!'
    def show
      render json: @team
    end
  
    # API Documentation for creating a new team
    api :POST, '/v1/users/:user_id/teams', 'Create a new team for this user'
    def create
      @team = @user.teams.new(team_params)
  
      if @team.save
        render json: @team, status: :created, message: 'Team was successfully created.'
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    end
  
    # API Documentation for updating a specific team
    api :PATCH, '/v1/users/:user_id/teams/:id', 'Update team with id'
    def update
      if @team.update(team_params)
        render json: @team, message: 'Team was successfully updated.'
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    end
  
    # API Documentation for deleting a team by ID
    api :DELETE, '/v1/users/:user_id/teams/:id', 'Delete team by id'
    def destroy
      authorize! :destroy, Team
      if @team.destroy
        render json: { message: 'Team deleted successfully!' }, status: :ok
      else
        render json: { error: 'Failed to delete the Team.' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_team
      @team = @user.teams.find(params[:id])
    end
  
    def team_params
      params.require(:team).permit(:team_name, :country, :founded_year, :description, :coach_name, :website, :trophy_photo, :league_id)
    end
  end
  
