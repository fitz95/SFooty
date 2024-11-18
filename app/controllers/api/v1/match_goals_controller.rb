class Api::V1::MatchGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_match
  before_action :set_match_goal, only: [:show, :update, :destroy]

  # GET /api/v1/users/:user_id/matches/:match_id/match_goals
  def index
    @match_goals = @match.match_goals
    render json: @match_goals, status: :ok
  end

  # GET /api/v1/users/:user_id/matches/:match_id/match_goals/:id
  def show
    render json: @match_goal, status: :ok
  end

  # POST /api/v1/users/:user_id/matches/:match_id/match_goals
  def create
    @goal = @match.match_goals.new(match_goal_params)
    @goal.user_id = @user.id # Ensure the goal is associated with the user

    if @goal.save
      render json: @goal, status: :created
    else
      render json: { errors: @goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_goals/:id
  def update
    if @match_goal.update(match_goal_params)
      render json: @match_goal, status: :ok
    else
      render json: { errors: @match_goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/:user_id/matches/:match_id/match_goals/:id
  def destroy
    @match_goal.destroy
    render json: { message: 'Match goal deleted successfully' }, status: :ok
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

  # Set the match goal using id from the params
  def set_match_goal
    @match_goal = @match.match_goals.find_by(id: params[:id], user_id: @user.id)
    if @match_goal.nil?
      render json: { error: 'Match goal not found for the user' }, status: :not_found
    end
  end

  # Strong parameters for match goals
  def match_goal_params
    params.require(:match_goal).permit(:scorer_id, :assister_id, :is_penalty, :is_own_goal, :goal_type,
                                       :goal_desc, :minute, :team_id, :match_shot_id, :x, :y, :expected_goal_value)
  end
end
