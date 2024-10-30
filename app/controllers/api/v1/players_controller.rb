class Api::V1::PlayersController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_team
    before_action :set_player, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/leagues/:league_id/players/', 'Get all players in this team'
    def index
        @players = @league.players
        render json: @players
    end

    api :GET, '/v1/users/:user_id/leagues/:league_id/players/:id', 'Get a specific player in the league'
    param :id, :number, desc: 'ID of the requested player', required: true
    error code: 404, desc: 'Player not found!'
    def show
      render json: @player
    end

    "a new player in this league"
    def new
        @player = @league.players.new
    end 

     api :POST, '/v1/users/:user_id/leagues/:league_id/players', 'Create a new player in the league'
    def create
      @player = @league.players.new(player_params)
      @player.user_id = @user.id  # Associate the player with the current user

      if @player.save
        render json: @player, status: :created, message: 'Player was successfully created.'
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    api :PATCH, '/v1/users/:user_id/leagues/:league_id/players/:id', 'Update a specific player in the league'
    def update
      if @player.update(player_params)
        render json: @player, message: 'Player was successfully updated.'
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    api :DELETE, '/v1/users/:user_id/leagues/:league_id/players/:id', 'Delete a specific player in the league'
    def destroy
      authorize! :destro, Team
      if @player.destroy
        render json: { message: 'Player deleted successfully!' }, status: :ok
      else
        render json: { error: 'Failed to delete the player.' }, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_league
      @league = @user.leagues.find(params[:league_id])
    end

    def set_player
      @player = @league.players.find(params[:id]) # Find the player within the league
    end

    def player_params
      params.require(:player).permit(:player_name, :nationality, :date_of_birth, :player_height, :player_weight, :player_shirt_number, :player_photo, :current_team_id)
    end
end
