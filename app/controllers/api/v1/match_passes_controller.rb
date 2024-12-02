class Api::V1::MatchPassesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_pass, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_passes
    def index
      @match_passes = @match.match_passes
      render json: @match_passes, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_passes/:id
    def show
      render json: @match_pass, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_passes/key_passes
    def key_passes
      @key_passes = MatchPass.where(match_id: params[:match_id], is_key_pass: true)
      render json: @key_passes, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_passes/completed?team_id=:team_id
    def completed_passes
      completed_pass_count = MatchPass.where(match_id: params[:match_id], team_id: params[:team_id], is_successful: true).count
      render json: { completed_passes: completed_pass_count }, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_passes/chances_created
    def chances_created
      chances_count = MatchPass.where(match_id: params[:match_id], is_key_pass: true, pass_outcome: 'completed').count
      render json: { chances_created: chances_count }, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_passes
    def create
      @pass = @match.match_passes.new(match_pass_params)
      @pass.user_id = @user.id # Ensure the pass is associated with the user
  
      if @pass.save
        render json: @pass, status: :created
      else
        render json: { errors: @pass.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_passes/:id
    def update
      if @match_pass.update(match_pass_params)
        render json: @match_pass, status: :ok
      else
        render json: { errors: @match_pass.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_passes/:id
    def destroy
      @match_pass.destroy
      render json: { message: 'Match pass deleted successfully' }, status: :ok
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
  
    # Set the match pass using id from the params
    def set_match_pass
      @match_pass = @match.match_passes.find_by(id: params[:id])
      if @match_pass.nil?
        render json: { error: 'Match pass not found' }, status: :not_found
      end
    end
  
    # Strong parameters for match passes
    def match_pass_params
      params.require(:match_pass).permit(
        :player_id, :team_id, :minute, :is_successful, :is_key_pass, :is_cross,
        :is_assist, :pass_type, :pass_outcome, :pass_start_x, :pass_start_y, 
        :pass_end_x, :pass_end_y, :pass_distance, :pass_direction, 
        :expected_assist_value, :assist_player_id, :received_by_player_id
        :is_goalkick, :is_throwout, :is_punt, :is_punt, :is_oepn_play, is_freekick
      )
    end
  end
  
