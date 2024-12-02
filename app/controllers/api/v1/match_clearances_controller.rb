class Api::V1::MatchClearancesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_clearance, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_clearances
    def index
      @match_clearances = @match.match_clearances
      render json: @match_clearances, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_clearances/:id
    def show
      render json: @match_clearance, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_clearances
    def create
      @clearance = @match.match_clearances.new(match_clearance_params)
      @clearance.user_id = @user.id
  
      if @clearance.save
        render json: @clearance, status: :created
      else
        render json: { errors: @clearance.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_clearances/:id
    def update
      if @match_clearance.update(match_clearance_params)
        render json: @match_clearance, status: :ok
      else
        render json: { errors: @match_clearance.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_clearances/:id
    def destroy
      @match_clearance.destroy
      render json: { message: 'Match clearance deleted successfully' }, status: :ok
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
  
    def set_match_clearance
      @match_clearance = @match.match_clearances.find_by(id: params[:id])
      render json: { error: 'Match clearance not found' }, status: :not_found unless @match_clearance
    end
  
    def match_clearance_params
      params.require(:match_clearance).permit(:player_id, :team_id, :clearance_type, :clearance_outcome, :x_coordinate, :y_coordinate, :minute, :successful, :under_pressure, :resulted_in_corner, :resulted_in_throw_in, :resulted_in_goa, :sweeper_clearance)
    end
  end
  
