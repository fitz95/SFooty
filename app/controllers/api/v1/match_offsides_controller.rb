class Api::V1::MatchOffsidesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_offside, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_offsides
    def index
      @match_offsides = @match.match_offsides
      render json: @match_offsides, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_offsides/:id
    def show
      render json: @match_offside, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_offsides
    def create
      @offside = @match.match_offsides.new(match_offside_params)
      @offside.user_id = @user.id
  
      if @offside.save
        render json: @offside, status: :created
      else
        render json: { errors: @offside.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_offsides/:id
    def update
      if @match_offside.update(match_offside_params)
        render json: @match_offside, status: :ok
      else
        render json: { errors: @match_offside.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_offsides/:id
    def destroy
      @match_offside.destroy
      render json: { message: 'Match offside deleted successfully' }, status: :ok
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
  
    def set_match_offside
      @match_offside = @match.match_offsides.find_by(id: params[:id])
      render json: { error: 'Match offside not found' }, status: :not_found unless @match_offside
    end
  
    def match_offside_params
      params.require(:match_offside).permit(:player_id, :team_id, :x_coordinate, :y_coordinate, :minute, :last_man, :resulted_in_goal, :opposing_team)
    end
  end
  