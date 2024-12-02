class Api::V1::MatchCornersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_corner, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_corners
    def index
      @match_corners = @match.match_corners
      render json: @match_corners, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_corners/:id
    def show
      render json: @match_corner, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_corners
    def create
      @match_corner = @match.match_corners.new(match_corner_params)
      @match_corner.user_id = @user.id
  
      if @match_corner.save
        render json: @match_corner, status: :created
      else
        render json: { errors: @match_corner.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_corners/:id
    def update
      if @match_corner.update(match_corner_params)
        render json: @match_corner, status: :ok
      else
        render json: { errors: @match_corner.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_corners/:id
    def destroy
      @match_corner.destroy
      render json: { message: 'Match corner deleted successfully' }, status: :ok
    end
  
    # Custom Route: Get all corners taken by a specific player
    # GET /api/v1/users/:user_id/matches/:match_id/match_corners/player/:player_id
    def corners_by_player
      @player_corners = @match.match_corners.where(player_id: params[:player_id])
      render json: @player_corners, status: :ok
    end
  
    # Custom Route: Get all corners by team
    # GET /api/v1/users/:user_id/matches/:match_id/match_corners/team/:team_id
    def corners_by_team
      @team_corners = @match.match_corners.where(team_id: params[:team_id])
      render json: @team_corners, status: :ok
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
  
    def set_match_corner
      @match_corner = @match.match_corners.find_by(id: params[:id])
      render json: { error: 'Match corner not found' }, status: :not_found unless @match_corner
    end
  
    def match_corner_params
      params.require(:match_corner).permit(:player_id, :team_id, :minute, :outcom, :side )
    end
  end
  
