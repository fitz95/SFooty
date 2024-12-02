class Api::V1::MatchDuelsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_duel, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_duels
    def index
      @match_duels = @match.match_duels
      render json: @match_duels, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_duels/:id
    def show
      render json: @match_duel, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_duels
    def create
      @duel = @match.match_duels.new(match_duel_params)
      @duel.user_id = @user.id
  
      if @duel.save
        render json: @duel, status: :created
      else
        render json: { errors: @duel.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_duels/:id
    def update
      if @match_duel.update(match_duel_params)
        render json: @match_duel, status: :ok
      else
        render json: { errors: @match_duel.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_duels/:id
    def destroy
      @match_duel.destroy
      render json: { message: 'Match duel deleted successfully' }, status: :ok
    end
  
    private
  
    def set_user
      @user = current_user
    end
  
    def set_match
      @match = Match.find(params[:match_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Match not found' }, status: :not_found
    end
  
    def set_match_duel
      @match_duel = @match.match_duels.find_by(id: params[:id])
      render json: { error: 'Match duel not found' }, status: :not_found unless @match_duel
    end
  
    def match_duel_params
      params.require(:match_duel).permit(:player_id, :opponent_player_id, :team_id, :x_coordinate, :y_coordinate, :minute, :duel_type, :last_man, :outcome)
    end
  end
  
