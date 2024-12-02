class Api::V1::MatchShotsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_match
    before_action :set_match_shot, only: [:show, :update, :destroy]

    # GET /api/v1/users/:user_id/matches/:match_id/match_shots
    def index
      @match_shots = @match.match_shots
      render json: @match_shots, status: :ok
    end

    # GET /api/v1/users/:user_id/matches/:match_id/match_shots/:id
    def show
      render json: @match_shot, status: :ok
    end

    # GET /api/v1/users/:user_id/matches/:match_id/match_shots/on_target
    def on_target
      @on_target_shots = MatchShot.on_target.where(match_id: params[:match_id])
      render json: @on_target_shots, status: :ok
    end

    # GET /api/v1/users/:user_id/matches/:match_id/match_shots/missed?team_id=:team_id
    def missed_shots
      missed_shots_count = MatchShot.missed.where(match_id: params[:match_id], team_id: params[:team_id]).count
      render json: { missed_shots: missed_shots_count }, status: :ok
    end

    # GET /api/v1/users/:user_id/matches/:match_id/match_shots/total_xg
    def total_xg
      total_xg = MatchShot.on_target.where(match_id: params[:match_id]).sum(:expected_goal_value)
      render json: { total_xg: total_xg }, status: :ok
    end

    # POST /api/v1/users/:user_id/matches/:match_id/match_shots
    def create
      @shot = @match.match_shots.new(match_shot_params)
      if @shot.save
        # Automatically create a goal record if the shot resulted in a goal
        render json: @shot, status: :created
      else
        render json: { errors: @shot.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_shots/:id
    def update
      if @match_shot.update(match_shot_params)
        render json: @match_shot, status: :ok
      else
        render json: { errors: @match_shot.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/users/:user_id/matches/:match_id/match_shots/:id
    def destroy
      @match_shot.destroy
      render json: { message: 'Match shot deleted successfully' }, status: :ok
    end

    private

    # Set the match using match_id from the params
    def set_match
      @match = Match.find(params[:match_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Match not found' }, status: :not_found
    end

    # Set the match shot using id from the params
    def set_match_shot
      @match_shot = @match.match_shots.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Match shot not found' }, status: :not_found
    end

    # Strong parameters for match shots
    def match_shot_params
      params.require(:match_shot).permit(:assist_player_id, :player_id, :team_id, :shot_type, :shot_outcome,
                                         :is_goal, :is_on_target, :minute, :x, :y, :expected_goal_value)
    end 
end
