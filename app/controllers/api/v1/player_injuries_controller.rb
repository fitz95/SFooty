class Api::V1::PlayerInjuriesController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_player_injury, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/player_injuries', 'Get all player_injuries'
    def index
        render json: @player_injuries
    end

    api :GET, '/v1/users/:user_id/player_injuries/:id', 'Get player_injury with id'
    def show
        render json: @player_injury
    end

    api :GET, '/v1/users/:user_id/player_injuries/new', 'Create a new player_injury'
    def new
        @player_injury = @user.player_injuries.new
    end

    api :GET, '/v1/users/:user_id/player_injuries/:id/edit', 'Edit player_injury with id'
    def edit
    end

    api :POST, '/v1/users/:user_id/player_injuries', 'Create a new player_injury'
    def create
        @player_injury = @user.player_injuries.new(player_injury_params)

        if @player_injury.save
            render json: @player_injury, notice: 'Player Injury was successfully created.'
        else
            render json: @player_injury.errors, status: :unprocessable_entity
        end
    end

    api :PATCH, '/v1/users/:user_id/player_injuries/:id', 'Update player_injury with id'
    def update
        if @player_injury.update(player_injury_params)
            render json: @player_injury, notice: 'Player Injury was successfully updated.'
        else
            render json: @player_injury.errors, status: :unprocessable_entity
        end
    end

    api :DELETE, '/v1/users/:user_id/player_injuries/:id', 'Delete player_injury by id'
    def destroy
        authorize! :destroy, PlayerInjury
        @player_injury = PlayerInjury.find_by(id: params[:id])
        if @player_injury.destroy
            render json: { message: 'Player Injury deleted successfully!' }, status: :ok
        else
            render json: { error: 'Failed to delete the Player Injury.' }, status: :unprocessable_entity
        end
    end

    private
    
    def set_user
        @user = User.find(params[:user_id])
    end 

    def set_player_injury
        @player_injury = PlayerInjury.find(params[:user])
    end

    def player_injury_params
        params.require(:player_injury).permit(:player_id, :injury_type, :description, :start_date, :end_date, :recovery_status)
    end

end
