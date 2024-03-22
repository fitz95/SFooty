class Api::V1::PlayerTransfersController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_player_transfer, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/player_transfers', 'Get all player_transfers'
    def index 
        @player_transfers = PlayerTransfer.all
        render json: @player_transfers
    end

    api :GET, '/v1/users/:user_id/player_transfers/:id', 'Get player_transfer with id'

    def show
        render json: @player_transfer
    end 

    api :GET, '/v1/users/:user_id/player_transfers/new', 'Create a new player_transfer'
    def new
        @player_transfer = @user.player_transfers.new
    end

    api :GET, '/v1/users/:user_id/player_transfers/:id/edit', 'Edit player_transfer with id'
    def edit
    end

    api :POST, '/v1/users/:user_id/player_transfers', 'Create a new player_transfer'

    def create
        @player_transfer = PlayerTransfer.new(player_transfer_params)

        if @player_transfer.save
            update_player_current_team(@player_transfer.player_id, @player_transfer.to_team_id)
            render json: @player_transfer, notice: 'Player Transfer was successfully created.'
        else
            render json: @player_transfer.errors, status: :unprocessable_entity
        end
    end

    api :PATCH, '/v1/users/:user_id/player_transfers/:id', 'Update player_transfer with id'
    def update
        if @player_transfer.update(player_transfer_params)
            update_player_current_team(@player_transfer.player_id, @player_transfer.to_team_id)
            render json: @player_transfer, notice: 'Player Transfer was successfully updated.'
        else
            render json: @player_transfer.errors, status: :unprocessable_entity
        end
    end
    
    api :DELETE, '/v1/users/:user_id/player_transfers/:id', 'Delete player_transfer by id'
    def destroy
        @player_transfer.destroy
        render json: { message: 'Player Transfer deleted successfully!' }, status: :ok
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    end 

    def set_player_transfer
        @player_transfer = @user.player_transfers.find(params[:id])
    end 

    def player_transfer_params
        params.require(:player_transfer).permit(:player_id, :from_team_id, :to_team_id, :transfer_date, :transfer_fee, :transfer_type, :transfer_window, :transfer_status, :transfer_contract, :transfer_contract_duration, :transfer_contract_salary, :transfer_contract_bonus, :transfer_contract_clause, :transfer_contract_release_clause, :transfer_contract_agent_fee, :transfer_contract_agent)
    end 

    def update_player_current_team(player_id, to_team_id)
        player = Player.find(player_id)
        player.update(current_team_id: to_team_id)
    end 

end
