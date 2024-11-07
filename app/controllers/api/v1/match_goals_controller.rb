# app/controllers/api/v1/match_goals_controller.rb
class Api::V1::MatchGoalsController < ApplicationController
    before_action :authenticate_request
    before_action :set_user
    before_action :set_match_goal, only: %i[show update destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/match_goals
    api :GET, '/api/v1/users/:user_id/match_goals', 'Get all match goals for a user'
    def index
      @match_goals = @user.match_goals
      render json: @match_goals
    end
  
    # GET /api/v1/users/:user_id/match_goals/:id
    api :GET, '/api/v1/users/:user_id/match_goals/:id', 'Get a match goal by id for a user'
    param :id, :number, desc: 'ID of the requested match goal', required: true
    error code: 404, desc: 'Match goal not found!'
    def show
      render json: @match_goal
    end
  
    # POST /api/v1/users/:user_id/match_goals
    api :POST, '/api/v1/users/:user_id/match_goals', 'Create a new match goal for a user'
    def create
      @match_goal = @user.match_goals.new(match_goal_params)
  
      if @match_goal.save
        render json: @match_goal, status: :created
      else
        render json: @match_goal.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH /api/v1/users/:user_id/match_goals/:id
    api :PATCH, '/api/v1/users/:user_id/match_goals/:id', 'Update a match goal by id for a user'
    def update
      if @match_goal.update(match_goal_params)
        render json: @match_goal
      else
        render json: @match_goal.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/match_goals/:id
    api :DELETE, '/api/v1/users/:user_id/match_goals/:id', 'Delete a match goal by id for a user'
    def destroy
      @match_goal.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_match_goal
      @match_goal = @user.match_goals.find(params[:id])
    end
  
    def match_goal_params
      params.require(:match_goal).permit(:match_id, :player_id, :minute, :type)
    end
  end
