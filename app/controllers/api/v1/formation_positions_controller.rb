class Api::V1::FormationPositionsController < ApplicationController
  before_action :authenticate_request
  before_action :set_user
  before_action :set_formation
  before_action :set_formation_position, only: %i[show update destroy]
  load_and_authorize_resource

  # GET /api/v1/users/:user_id/formations/:formation_id/formation_positions
  def index
    @formation_positions = @formation.formation_positions
    render json: @formation_positions
  end

  # GET /api/v1/users/:user_id/formations/:formation_id/formation_positions/:id
  def show
    render json: @formation_position
  end

  # POST /api/v1/users/:user_id/formations/:formation_id/formation_positions
  def create
    @formation_position = @formation.formation_positions.new(formation_position_params)
    if @formation_position.save
      render json: @formation_position, status: :created
    else
      render json: @formation_position.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/:user_id/formations/:formation_id/formation_positions/:id
  def update
    if @formation_position.update(formation_position_params)
      render json: @formation_position
    else
      render json: @formation_position.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/:user_id/formations/:formation_id/formation_positions/:id
  def destroy
    @formation_position.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_formation
    @formation = @user.formations.find(params[:formation_id])
  end

  def set_formation_position
    @formation_position = @formation.formation_positions.find(params[:id])
  end

  def formation_position_params
    params.require(:formation_position).permit(:position_name, :position_order, :position_number)
  end
end

