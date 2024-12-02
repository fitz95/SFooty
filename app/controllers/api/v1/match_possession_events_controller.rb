class Api::V1::MatchPossessionEventsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_match
    before_action :set_match_possession_event, only: [:show, :update, :destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_possession_events
    def index
      @match_possession_events = @match.match_possession_events
      render json: @match_possession_events, status: :ok
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/match_possession_events/:id
    def show
      render json: @match_possession_event, status: :ok
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/match_possession_events
    def create
      @match_possession_event = @match.match_possession_events.new(match_possession_event_params)
  
      if @match_possession_event.save
        render json: @match_possession_event, status: :created
      else
        render json: { errors: @match_possession_event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_possession_events/:id
    def update
      if @match_possession_event.update(match_possession_event_params)
        render json: @match_possession_event, status: :ok
      else
        render json: { errors: @match_possession_event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/match_possession_events/:id
    def destroy
      @match_possession_event.destroy
      render json: { message: 'Match possession event deleted successfully' }, status: :ok
    end

    # Get calculated possession events for a match by match_id
    def possession_percentages
        possession_data = @match.match_possession_events
                                 .group(:team_id)
                                 .pluck(:team_id, "SUM(EXTRACT(EPOCH FROM (end_time - start_time)))")
    
        total_time = possession_data.sum { |_, time| time }
        if total_time.zero?
          render json: { message: 'No possession data available for this match' }, status: :ok
        else
          percentages = possession_data.each_with_object({}) do |(team_id, time), result|
            result[team_id] = (time / total_time * 100).round(2)
          end
          render json: { possession_percentages: percentages }, status: :ok
        end
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
  
    def set_match_possession_event
      @match_possession_event = @match.match_possession_events.find_by(id: params[:id])
      render json: { error: 'Match possession event not found' }, status: :not_found unless @match_possession_event
    end
  
    def match_possession_event_params
      params.require(:match_possession_event).permit(
        :team_id, :start_time, :end_time, :possession_start_zone, :possession_end_zone,
        :possession_direction, :possession_type, :attacking_threat, :conceding_threat, :description,
        :is_goal, :additional_time, :chance_created
    
      )
    end
  end
  