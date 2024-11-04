class Api::V1::PlayersController < ApplicationController
  before_action :authenticate_request
  load_and_authorize_resource
  before_action :set_user
  before_action :set_player, only: %i[show update destroy]

  api :GET, '/v1/players/', 'Get all players'
  def index
    @players = Player.all
    render json: @players
  end

  api :GET, '/v1/players/:id', 'Get a specific player'
  param :id, :number, desc: 'ID of the requested player', required: true
  error code: 404, desc: 'Player not found!'
  def show
    render json: @player
  end

  api :POST, '/v1/players', 'Create a new player'
  def create
    @player = @user.players.new(player_params)

    if @player.save
      render json: @player, status: :created, message: 'Player was successfully created.'
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/v1/players/:id', 'Update a specific player'
  def update
    if @player.update(player_params)
      render json: @player, message: 'Player was successfully updated.'
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/v1/players/:id', 'Delete a specific player'
  def destroy
    if @player.destroy
      render json: { message: 'Player deleted successfully!' }, status: :ok
    else
      render json: { error: 'Failed to delete the player.' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_player
    @player = Player.find(params[:id]) # Find the player by ID
  end

  def player_params
    params.require(:player).permit(:player_name, :nationality, :date_of_birth, :player_height, :player_weight, :player_shirt_number, :player_photo, :current_team_id)
  end
end
