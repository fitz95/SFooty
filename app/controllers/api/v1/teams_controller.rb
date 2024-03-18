class Api::V1::TeamsController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_league
    before_action :set_team, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams', 'Get all teams in this league'
    def index
        @teams = @league.teams.where(league_id: @league.id)
        render json: @teams
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:id', 'Get team with id'
    param :id, :number, desc: 'id of the requested team', required: true
    error code: 404, desc: 'Team not found!'
    def show
        render json: @team
    end

    api :POST, '/v1/users/:user_id/leagues/:league_id/teams', 'Create
    a new team in this league'
    def new 
        @team = @league.teams.new
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/edit', 'Edit team with id'
    def edit
    end

    api :POST, '/v1/users/:user_id/leagues/:league_id/teams', 'Create a new team in this league'
    def create
        @team = @league.teams.new(team_params)
        @team.user_id = current_user.id

        if @team.save
           render json: @team, notice: 'Team was successfully created.'
        else
            render json: @team.errors, status: :unprocessable_entity
        end
    end

    api :PATCH/PUT '/v1/users/:user_id/leagues/:leagues_id/teams/:id', 'Update team with id'
    def update
        if @team.update(team_params)
            render json: @team, notice: 'Team was successfully updated.'
        else
            render json: @team.errors, status: :unprocessable_entity
        end
    end
    
    api :DELETE, '/v1/users/:user_id/leagues/:league_id/teams/:id', 'Delete team by id'
    def destroy
        authorize! :destroy, Team
        @team = Team.find_by(id: params[:id])
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
    def set_league
        @league = League.find(params[:league_id])
    end
    def set_team
        @team = Team.find(params[:id])
       end
    def team_params
        params.require(:team).permit(:team_name, :country, :founded_year, :description, :coach_name, :website, :trophy_photo)
    end
    
end
