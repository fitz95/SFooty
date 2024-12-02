class Api::V1::PlayersController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_team
    before_action :set_player, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/players/', 'Get all players in this team'
    def index
        @players = Player.where(current_team_id: @team.id)
        render json: @players
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/players/:id', 'Get player with id'
    param :id, :number, desc: 'id of the requested player', required: true
    error code: 404, desc: 'Player not found!'
    def show
        render json: @player
    end

    api :POST, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/players/', 'Create a new player in this team'
    def new 
        @player = @team.players.new
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/players/:player_id/edit', 'Edit player with id'
    def edit
    end

    api :POST, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/players/', 'Create a new player in this team'
    def create
        @player = @team.players.new(player_params)

        if @player.save
            @player.user_id = current_user.id
            @player.current_team_id = @team.id
            render json: @player, notice: 'Player was successfully created.'
        else
            render json: @player.errors, status: :unprocessable_entity
        end
    end

    api :PATCH, '/v1/users/:user_id/leagues/:leagues_id/teams/:team_id/players/:id', 'Update player with id'
    def update
        if @player.update(player_params)
            @player.user_id = current_user.id
            render json: @player, notice: 'Player was successfully updated.'
        else
            render json: @player.errors, status: :unprocessable_entity
        end
    end
    
    api :DELETE, '/v1/users/:user_id/leagues/:league_id/teams/:team_id/players/:id', 'Delete player by id'
    def destroy
        authorize! :destroy, Player
        @player = Player.find_by(id: params[:id])
        if @player.destroy
            render json: { message: 'Player deleted successfully!' }, status: :ok
        else
            render json: { error: 'Failed to delete the Player.' }, status: :unprocessable_entity
        end
    end
    
    private
    def set_user
        @user = User.find(params[:user_id])
    end

    def set_team
        @team = Team.find(params[:team_id])
    end
    def set_player
        @player = Player.find(params[:id])
    end
    def player_params
        params.require(:player).permit(:player_name, :nationality, :date_of_birth, :player_height, :player_weight, :player_shirt_number, :player_photo, :current_team_id)
    end
end
