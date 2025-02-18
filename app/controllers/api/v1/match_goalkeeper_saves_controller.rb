class Api::V1::MatchGoalkeeperSavesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_goalkeeper_save, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_goalkeeper_saves
    def index
      @match_goalkeeper_saves = @match.match_goalkeeper_saves
      render json: @match_goalkeeper_saves, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_goalkeeper_saves/:id
    def show
      render json: @match_goalkeeper_save, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_goalkeeper_saves
    def create
      @goalkeeper_save = @match.match_goalkeeper_saves.new(match_goalkeeper_save_params)
      @goalkeeper_save.user_id = @user.id
  
      if @goalkeeper_save.save
        render json: @goalkeeper_save, status: :created
      else
        render json: { errors: @goalkeeper_save.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_goalkeeper_saves/:id
    def update
      if @match_goalkeeper_save.update(match_goalkeeper_save_params)
        render json: @match_goalkeeper_save, status: :ok
      else
        render json: { errors: @match_goalkeeper_save.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_goalkeeper_saves/:id
    def destroy
      @match_goalkeeper_save.destroy
      render json: { message: 'Match goalkeeper save deleted successfully' }, status: :ok
    end

    # Custom Route: Get all goalkeeper saves involving a specific player
    # GET /api/v1/users/:user_id/matches/:match_id/match_goalkeeper_saves/player/:player_id
    def saves_by_player
      @player_saves = @match.match_goalkeeper_saves.where(player_id: params[:player_id])
      render json: @player_saves, status: :ok
    end

  
    def set_user
      @user = current_user
    end
  
    def set_match
      @match = Match.find(params[:match_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Match not found' }, status: :not_found
    end
  
    def set_match_goalkeeper_save
      @match_goalkeeper_save = @match.match_goalkeeper_saves.find_by(id: params[:id])
      render json: { error: 'Match goalkeeper save not found' }, status: :not_found unless @match_goalkeeper_save
    end
  
    def match_goalkeeper_save_params
      params.require(:match_goalkeeper_save).permit(:player_id, :team_id, :save_type, :is_penalty_save, :body_part, is_close_range_save, is_one_on_one_save, is_reaction_save, :xgp, :minute, :save_outcomeoutcome, :distance_from_goal, :blocked_player_id)
    end
  end
  