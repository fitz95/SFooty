class Api::V1::MatchInterceptionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_interception, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_interceptions
    def index
      @match_interceptions = @match.match_interceptions
      render json: @match_interceptions, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_interceptions/:id
    def show
      render json: @match_interception, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_interceptions
    def create
      @interception = @match.match_interceptions.new(match_interception_params)
      @interception.user_id = @user.id
  
      if @interception.save
        render json: @interception, status: :created
      else
        render json: { errors: @interception.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_interceptions/:id
    def update
      if @match_interception.update(match_interception_params)
        render json: @match_interception, status: :ok
      else
        render json: { errors: @match_interception.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_interceptions/:id
    def destroy
      @match_interception.destroy
      render json: { message: 'Match interception deleted successfully' }, status: :ok
    end
  
    private
  
    # Set the current user
    def set_user
      @user = current_user
    end
  
    # Set the match
    def set_match
      @match = Match.find(params[:match_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Match not found' }, status: :not_found
    end
  
    # Set the match interception
    def set_match_interception
      @match_interception = @match.match_interceptions.find_by(id: params[:id])
      render json: { error: 'Match interception not found' }, status: :not_found unless @match_interception
    end
  
    # Strong parameters
    def match_interception_params
      params.require(:match_interception).permit(:player_id, :team_id, :interception_type, :x_coordinate, :y_coordinate, :minute, :successful, :outcome, :match_pass_id, is_cross,
                                                 :is_high_claim, :is_low_claim, :body_part, :is_dropped_down, :is_corner, :is_free_kick)
    end
  end
  