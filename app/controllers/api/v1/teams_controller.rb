class Api::V1::TeamsController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_league
    before_action :set_team, only: %i[show edit update destroy]

    api :GET, '/users/:user_id/leagues/:league_id/teams', 'Get all teams in this league'
    def index
        @teams = @league.teams.where(league_id: @league.id)
        render json: @teams
    end

    api :GET, '/users/:user_id/leagues/:league_id/teams/:id', 'Get team with id'
    param :id, :number, desc: 'id of the requested team', required: true
    error code: 404, desc: 'Team not found!'
    def show
        render json: @team
    end

    api :POST, '/users/:user_id/leagues/:league_id/teams', 'Create
    a new team in this league'
    def new 
        @team = @league.teams.new
    end

    api :POST, '/users/:user_id/leagues/:league_id/teams/:team_id/edit', 'Edit team with id'
    def edit
    end

    api :POST, '/users/:user_id/leagues/:league_id/teams', 'Create a new team in this league'
    def create
        @team = @league.teams.new(team_params)
        @team.user_id = current_user.id

        if @team.save
            redirect_to user_league_team_path(current_user, @league, @team), notice: 'Team was successfully created.'
        else
            render :new
        end
    end

    api :DELETE, '/users/:user_id/leagues/:league_id/teams/:id', 'Delete team by id'
    def destroy
        @team.destroy
        redirect_to user_league_teams_path(current_user, @league), notice: 'Team was successfully destroyed.'
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
