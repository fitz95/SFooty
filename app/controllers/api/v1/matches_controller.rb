# app/controllers/api/v1/matches_controller.rb
class Api::V1::MatchesController < ApplicationController
    before_action :authenticate_request
    before_action :set_user
    before_action :set_match, only: %i[show update destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches
    api :GET, '/api/v1/users/:user_id/matches', 'Get all matches for a user'
    def index
      @matches = @user.matches
      render json: @matches
    end
  
    # GET /api/v1/users/:user_id/matches/:id
    api :GET, '/api/v1/users/:user_id/matches/:id', 'Get a match by id for a user'
    param :id, :number, desc: 'ID of the requested match', required: true
    error code: 404, desc: 'Match not found!'
    def show
      render json: @match
    end
  
    # POST /api/v1/users/:user_id/matches
    api :POST, '/api/v1/users/:user_id/matches', 'Create a new match for a user'
    def create
      @match = @user.matches.new(match_params)
  
      if @match.save
        render json: @match, status: :created
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH /api/v1/users/:user_id/matches/:id
    api :PATCH, '/api/v1/users/:user_id/matches/:id', 'Update a match by id for a user'
    def update
      if @match.update(match_params)
        render json: @match
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:id
    api :DELETE, '/api/v1/users/:user_id/matches/:id', 'Delete a match by id for a user'
    def destroy
      @match.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_match
      @match = @user.matches.find(params[:id])
    end
  
    def match_params
      params.require(:match).permit(:date, :time, :stadium_id, :referee_id, :home_team_id, :away_team_id, :league_id, :game_week_id, :competition_id)
    end
  end
  
