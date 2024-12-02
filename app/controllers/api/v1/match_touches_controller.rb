class Api::V1::MatchTouchesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_touch, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_touches
    def index
      @match_touches = @match.match_touches
      render json: @match_touches, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_touches/:id
    def show
      render json: @match_touch, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_touches/in_box
    def in_box
      @in_box_touches = @match.match_touches.where(in_box: true)
      render json: @in_box_touches, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_touches
    def create
      @touch = @match.match_touches.new(match_touch_params)
      @touch.user_id = @user.id # Ensure the touch is associated with the user
  
      if @touch.save
        render json: @touch, status: :created
      else
        render json: { errors: @touch.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_touches/:id
    def update
      if @match_touch.update(match_touch_params)
        render json: @match_touch, status: :ok
      else
        render json: { errors: @match_touch.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_touches/:id
    def destroy
      @match_touch.destroy
      render json: { message: 'Match touch deleted successfully' }, status: :ok
    end
  
    private
  
    # Set the current user
    def set_user
      @user = current_user
    end
  
    # Set the match using match_id from the params
    def set_match
      @match = Match.find(params[:match_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Match not found' }, status: :not_found
    end
  
    # Set the match touch using id from the params
    def set_match_touch
      @match_touch = @match.match_touches.find_by(id: params[:id])
      if @match_touch.nil?
        render json: { error: 'Match touch not found for the user' }, status: :not_found
      end
    end
  
    # Strong parameters for match touches
    def match_touch_params
      params.require(:match_touch).permit(:player_id, :team_id, :touch_type, :touch_direction, :successful, 
                                          :x_coordinate, :y_coordinate, :minute, :in_box)
    end
  end
  