class Api::V1::MatchTacklesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_tackle, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_tackles
    def index
      @match_tackles = @match.match_tackles
      render json: @match_tackles, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_tackles/:id
    def show
      render json: @match_tackle, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_tackles
    def create
      @tackle = @match.match_tackles.new(match_tackle_params)
      @tackle.user_id = @user.id
  
      if @tackle.save
        render json: @tackle, status: :created
      else
        render json: { errors: @tackle.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_tackles/:id
    def update
      if @match_tackle.update(match_tackle_params)
        render json: @match_tackle, status: :ok
      else
        render json: { errors: @match_tackle.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_tackles/:id
    def destroy
      @match_tackle.destroy
      render json: { message: 'Match tackle deleted successfully' }, status: :ok
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
  
    # Set the match tackle
    def set_match_tackle
      @match_tackle = @match.match_tackles.find_by(id: params[:id])
      render json: { error: 'Match tackle not found' }, status: :not_found unless @match_tackle
    end
  
    # Strong parameters
    def match_tackle_params
      params.require(:match_tackle).permit(:player_id, :team_id, :tackle_type, :x_coordinate, :y_coordinate, :minute, :successful, :last_man, :resulted_in_foul, :resulted_in_card :tackle_outcome)
    end
  end
  