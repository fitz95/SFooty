class Api::V1::LineupPlayersController < ApplicationController
    before_action :authenticate_request
    before_action :set_user
    before_action :set_match_lineup
    before_action :set_lineup_player, only: %i[show update destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/match_lineups/:match_lineup_id/lineup_players
    def index
      @lineup_players = @match_lineup.lineup_players
      render json: @lineup_players
    end
  
    # GET /api/v1/users/:user_id/match_lineups/:match_lineup_id/lineup_players/:id
    def show
      render json: @lineup_player
    end
  
    # POST /api/v1/users/:user_id/match_lineups/:match_lineup_id/lineup_players
    def create
      @lineup_player = @match_lineup.lineup_players.new(lineup_player_params)
      @lineup_player.user = @user
  
      if @lineup_player.save
        render json: @lineup_player, status: :created
      else
        render json: @lineup_player.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/match_lineups/:match_lineup_id/lineup_players/:id
    def update
      if @lineup_player.update(lineup_player_params)
        render json: @lineup_player
      else
        render json: @lineup_player.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/match_lineups/:match_lineup_id/lineup_players/:id
    def destroy
      @lineup_player.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_match_lineup
      @match_lineup = @user.match_lineups.find(params[:match_lineup_id])
    end
  
    def set_lineup_player
      @lineup_player = @match_lineup.lineup_players.find(params[:id])
    end
  
    def lineup_player_params
      params.require(:lineup_player).permit(:player_id, :formation_position_id, :position, :is_captain, :is_substitute)
    end
  end
  