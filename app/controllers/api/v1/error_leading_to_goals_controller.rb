class Api::V1::ErrorLeadingToGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_match
  before_action :set_error_leading_to_goal, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /api/v1/users/:user_id/error_leading_to_goals
  def index
    @error_leading_to_goals = ErrorLeadingToGoal.all
    render json: @error_leading_to_goals, status: :ok
  end


  # GET /api/v1/users/:user_id/error_leading_to_goals/:id
  def show
    render json: @error_leading_to_goal, status: :ok
  end

  # POST /api/v1/users/:user_id/error_leading_to_goals
  def create
    @error_leading_to_goal = ErrorLeadingToGoal.new(error_leading_to_goal_params)

    if @error_leading_to_goal.save
      render json: @error_leading_to_goal, status: :created
    else
      render json: @error_leading_to_goal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/:user_id/error_leading_to_goals/:id
  def update
    if @error_leading_to_goal.update(error_leading_to_goal_params)
      render json: @error_leading_to_goal, status: :ok
    else
      render json: @error_leading_to_goal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/:user_id/error_leading_to_goals/:id
  def destroy
    @error_leading_to_goal.destroy
    head :no_content
  end

  # GET /api/v1/users/:user_id/error_leading_to_goals/players/:player_id
  def index_by_player
    @error_leading_to_goals = ErrorLeadingToGoal.where(player_id: params[:player_id])
    render json: @error_leading_to_goals, status: :ok
  end

    # GET /api/v1/users/:user_id/error_leading_to_goals/teams/:team_id
    def index_by_team
      @error_leading_to_goals = ErrorLeadingToGoal.where(team_id: params[:team_id])
      render json: @error_leading_to_goals, status: :ok
    end

  private

    def set_user
      @user = current_user
    end

    def set_error_leading_to_goal
      @error_leading_to_goal = ErrorLeadingToGoal.find(params[:id])
    end 

    def error_leading_to_goal_params
      params.require(:error_leading_to_goal).permit(:match_id, :team_id, :player_id, :error_type, :error_description, :match_goal, :minute, :additional_time)
    end
end
