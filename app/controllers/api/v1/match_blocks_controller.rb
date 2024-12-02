# app/controllers/api/v1/match_blocks_controller.rb
class Api::V1::MatchBlocksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_block, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_blocks
    def index
      @match_blocks = @match.match_blocks
      render json: @match_blocks, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_blocks/:id
    def show
      render json: @match_block, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_blocks/successful
    def successful_blocks
      @successful_blocks = MatchBlock.successful.where(match_id: params[:match_id])
      render json: @successful_blocks, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_blocks/defensive
    def defensive_blocks
      @defensive_blocks = MatchBlock.defensive.where(match_id: params[:match_id])
      render json: @defensive_blocks, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_blocks
    def create
      @match_block = @match.match_blocks.new(match_block_params)
      @match_block.user_id = @user.id
  
      if @match_block.save
        render json: @match_block, status: :created
      else
        render json: { errors: @match_block.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_blocks/:id
    def update
      if @match_block.update(match_block_params)
        render json: @match_block, status: :ok
      else
        render json: { errors: @match_block.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_blocks/:id
    def destroy
      @match_block.destroy
      render json: { message: 'MatchBlock deleted successfully' }, status: :ok
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
  
    # Set the match_block using id from the params
    def set_match_block
      @match_block = @match.match_blocks.find_by(id: params[:id])
      if @match_block.nil?
        render json: { error: 'MatchBlock not found for the match' }, status: :not_found
      end
    end
  
    # Strong parameters for match_block
    def match_block_params
      params.require(:match_block).permit(:player_id, :team_id, :opponent_id, :is_successful, :block_type, :minute, :x, :y, :block_outcome, :distance)
    end
  end
  