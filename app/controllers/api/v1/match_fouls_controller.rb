class Api::V1::MatchFoulsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_foul, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_fouls
    def index
      @match_fouls = @match.match_fouls
      render json: @match_fouls, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_fouls/:id
    def show
      render json: @match_foul, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_fouls
    def create
      @foul = @match.match_fouls.new(match_foul_params)
      @foul.user_id = @user.id
  
      if @foul.save
        render json: @foul, status: :created
      else
        render json: { errors: @foul.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_fouls/:id
    def update
      if @match_foul.update(match_foul_params)
        render json: @match_foul, status: :ok
      else
        render json: { errors: @match_foul.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_fouls/:id
    def destroy
      @match_foul.destroy
      render json: { message: 'Match foul deleted successfully' }, status: :ok
    end

    # Custom Route: Get all fouls involving a specific player
    # GET /api/v1/users/:user_id/matches/:match_id/match_fouls/player/:player_id
    def fouls_by_player
        @player_fouls = @match.match_fouls.where(player_id: params[:player_id])
        render json: @player_fouls, status: :ok
    end

    # Custom Route: Get all fouls involving a specific team
    # GET /api/v1/users/:user_id/matches/:match_id/match_fouls/team/:team_id
    def fouls_by_team
        @team_fouls = @match.match_fouls.where(team_id: params[:team_id])
        render json: @team_fouls, status: :ok
    end

    # Custom Route: Get all fouls with yellow cards
    # GET /api/v1/users/:user_id/matches/:match_id/match_fouls/yellow_cards
    def yellow_cards
        @yellow_cards = @match.match_fouls.where(card_issued: 'Yellow Card')
        render json: @yellow_cards, status: :ok
    end

    # Custom Route: Get all fouls with red cards
    # GET /api/v1/users/:user_id/matches/:match_id/match_fouls/red_cards
    def red_cards    
        @red_cards = @match.match_fouls.where(card_issued: 'Red Card')
        render json: @red_cards, status: :ok
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
  
    def set_match_foul
      @match_foul = @match.match_fouls.find_by(id: params[:id])
      render json: { error: 'Match foul not found' }, status: :not_found unless @match_foul
    end
  
    def match_foul_params
      params.require(:match_foul).permit(
        :player_id, :team_id, :minute, :foul_type, :severity, :fouled_player_id, :fouled_official_id,
        :card_issued, :penalty_awarded, :tackle_id, :x_coordinate, :y_coordinate, :opposing_team, :description
      )
    end
  end
  
