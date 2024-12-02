class Api::V1::TrophiesController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_team
    before_action :set_league
    before_action :set_trophy, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/trophies/', 'Get all trophies in this team'
    def index
        @trophies = Trophy.where(team_id: @team.id)
        render json: @trophies
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/trophies/:id', 'Get Trophy with id'
    param :id, :number, desc: 'id of the requested Trophy', required: true
    error code: 404, desc: 'Trophy not found!'
    def show
        render json: @Trophy
    end

    api :POST, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/trophies/', 'Create a new Trophy in this team'
    def new 
        @trophy = @team.trophies.new
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/trophies/:Trophy_id/edit', 'Edit Trophy with id'
    def edit
    end

    api :POST, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/trophies/', 'Create a new Trophy in this team'
    def create
        @trophy = @team.trophies.new(trophy_params)
        @trophy.user_id = current_user.id
        @trophy.team_id = @team.id
        @trophy.league_id = @league.id

        if @trophy.save
            render json: @trophy, notice: 'Trophy was successfully created.'
        else
            render json: @trophy.errors, status: :unprocessable_entity
        end
    end

    api :PATCH, '/v1/users/:user_id/leagues/:leagues_id/teams/:team_id/trophies/:id', 'Update Trophy with id'
    def update
        if @trophy.update(trophy_params)
            @trophy.user_id = current_user.id
            render json: @trophy, notice: 'Trophy was successfully updated.'
        else
            render json: @trophy.errors, status: :unprocessable_entity
        end
    end
    
    api :DELETE, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/trophies/:id', 'Delete Trophy by id'
    def destroy
        authorize! :destroy, Trophy
        @Trophy = Trophy.find_by(id: params[:id])
        if @trophy.destroy
            render json: { message: 'Trophy deleted successfully!' }, status: :ok
        else
            render json: { error: 'Failed to delete the Trophy.' }, status: :unprocessable_entity
        end
    end
    
    private
    def set_user
        @user = User.find(params[:user_id])
    end

    def set_team
        @team = Team.find(params[:team_id])
    end

    def set_league
        @league = League.find(params[:league_id])
    end

    def set_Trophy
        @trophy = Trophy.find(params[:id])
    end
    def trophy_params
        params.require(:trophy).permit(:trophy_name, :year, :trophy_photo, :team_id, :league_id)
    end
end
