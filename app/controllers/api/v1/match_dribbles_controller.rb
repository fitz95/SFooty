class Api::V1::MatchDribblesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_dribble, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_dribbles
    def index
      @match_dribbles = @match.match_dribbles
      render json: @match_dribbles, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_dribbles/:id
    def show
      render json: @match_dribble, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_dribbles/successful
    def successful
      successful_dribbles = MatchDribble.successful.where(match_id: params[:match_id])
      render json: successful_dribbles, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_dribbles
    def create
      @dribble = @match.match_dribbles.new(match_dribble_params)
      @dribble.user_id = @user.id
  
      if @dribble.save
        render json: @dribble, status: :created
      else
        render json: { errors: @dribble.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_dribbles/:id
    def update
      if @match_dribble.update(match_dribble_params)
        render json: @match_dribble, status: :ok
      else
        render json: { errors: @match_dribble.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_dribbles/:id
    def destroy
      @match_dribble.destroy
      render json: { message: 'Match dribble deleted successfully' }, status: :ok
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
  
    def set_match_dribble
      @match_dribble = @match.match_dribbles.find_by(id: params[:id])
      render json: { error: 'Match dribble not found' }, status: :not_found if @match_dribble.nil?
    end
  
    def match_dribble_params
      params.require(:match_dribble).permit(:player_id, :team_id, :opponent_id, :minute, :is_successful,
                                            :dribble_type, :outcome, :x, :y)
    end
  end
  
