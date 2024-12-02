class Api::V1::StadiumsController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_team
    before_action :set_stadium, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/stadiums/', 'Get all stadiums in this team'
    def index
        @stadiums = Stadium.where(team_id: @team.id)
        render json: @stadiums
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/stadiums/:id', 'Get Stadium with id'
    param :id, :number, desc: 'id of the requested Stadium', required: true
    error code: 404, desc: 'Stadium not found!'
    def show
        render json: @stadium
    end

    api :POST, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/stadiums/', 'Create a new Stadium in this team'
    def new 
        @stadium = @team.stadiums.new
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/stadiums/:id/edit', 'Edit Stadium with id'
    def edit
    end

    api :POST, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/stadiums/', 'Create a new Stadium in this team'
    def create
        @stadium = @team.stadiums.new(stadium_params)
        @stadium.user_id = current_user.id
        @stadium.team_id = @team.id

        if @stadium.save
            render json: @stadium, notice: 'Stadium was successfully created.'
        else
            render json: @stadium.errors, status: :unprocessable_entity
        end
    end

    api :PATCH, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/stadiums/:id', 'Update Stadium with id'
    def update
        if @stadium.update(stadium_params)
            @stadium.user_id = current_user.id
            render json: @stadium, notice: 'Stadium was successfully updated.'
        else
            render json: @stadium.errors, status: :unprocessable_entity
        end
    end
    
    api :DELETE, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/stadiums/:id', 'Delete Stadium by id'
    def destroy
        authorize! :destroy, Stadium
        if @stadium.destroy
            render json: { message: 'Stadium deleted successfully!' }, status: :ok
        else
            render json: { error: 'Failed to delete the Stadium.' }, status: :unprocessable_entity
        end
    end
    
    private
    def set_user
        @user = User.find(params[:user_id])
    end

    def set_team
        @team = Team.find(params[:team_id])
    end

    def set_stadium
        @stadium = Stadium.find(params[:id])
    end

    def stadium_params
        params.require(:stadium).permit(:stadium_name, :city, :country, :capacity, :year_opened, :stadium_photo, :team_id)
    end
        
end
