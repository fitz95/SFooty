class Api::V1::GameWeeksController < ApplicationController
  before_action :authenticate_request
  load_and_authorize_resource
  before_action :set_user
  before_action :set_game_week, only: %i[show update destroy]

  # API Documentation for getting all game weeks for a user
  api :GET, '/v1/users/:user_id/game_weeks', 'Get all game weeks for the user'
  def index
    @game_weeks = @user.game_weeks
    render json: @game_weeks
  end

  # API Documentation for getting a specific game week by ID
  api :GET, '/v1/users/:user_id/game_weeks/:id', 'Get game week with id'
  param :id, :number, desc: 'ID of the requested game week', required: true
  error code: 404, desc: 'Game week not found!'
  def show
    render json: @game_week
  end

  # API Documentation for creating a new game week
  api :POST, '/v1/users/:user_id/game_weeks', 'Create a new game week for this user'
  def create
    @game_week = @user.game_weeks.new(game_week_params)

    if @game_week.save
      render json: @game_week, status: :created, message: 'Game week was successfully created.'
    else
      render json: @game_week.errors, status: :unprocessable_entity
    end
  end

  # API Documentation for updating a specific game week
  api :PATCH, '/v1/users/:user_id/game_weeks/:id', 'Update game week with id'
  def update
    if @game_week.update(game_week_params)
      render json: @game_week, message: 'Game week was successfully updated.'
    else
      render json: @game_week.errors, status: :unprocessable_entity
    end
  end

  # API Documentation for deleting a game week by ID
  api :DELETE, '/v1/users/:user_id/game_weeks/:id', 'Delete game week by id'
  def destroy
    authorize! :destroy, GameWeek
    if @game_week.destroy
      render json: { message: 'Game week deleted successfully!' }, status: :ok
    else
      render json: { error: 'Failed to delete the game week.' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_game_week
    @game_week = @user.game_weeks.find(params[:id])
  end

  def game_week_params
    params.require(:game_week).permit( :league_id, :week_number, :season, :start_date, :end_date, :user_id, :season_id, :description, :completed)
  end
end
