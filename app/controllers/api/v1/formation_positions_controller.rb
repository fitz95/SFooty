class Api::V1::FormationPositionsController < ApplicationController
    before_action :authenticate_request
    before_action :set_user
    before_action :set_formation, only: %i[show update destroy]
    load_and_authorize_resource

    # GET /api/v1/formations/:formation_id/formation_positions
  api :GET, '/api/v1/formations/:formation_id/formation_positions', 'Get all positions for a specific formation'
  def index
    @formation_positions = @formation.formation_positions
    render json: @formation_positions
  end

  # GET /api/v1/formations/:formation_id/formation_positions/:id
  api :GET, '/api/v1/formations/:formation_id/formation_positions/:id', 'Get a specific position by ID for a formation'
  param :id, :number, desc: 'ID of the requested position', required: true
  def show
    render json: @formation_position
  end

  # POST /api/v1/formations/:formation_id/formation_positions
  api :POST, '/api/v1/formations/:formation_id/formation_positions', 'Create a new position for a formation'
  def create
    @formation_position = @formation.formation_positions.new(formation_position_params)
    if @formation_position.save
      render json: @formation_position, status: :created
    else
      render json: @formation_position.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/formations/:formation_id/formation_positions/:id
  api :PATCH, '/api/v1/formations/:formation_id/formation_positions/:id', 'Update an existing position by ID'
  def update
    if @formation_position.update(formation_position_params)
      render json: @formation_position
    else
      render json: @formation_position.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/formations/:formation_id/formation_positions/:id
  api :DELETE, '/api/v1/formations/:formation_id/formation_positions/:id', 'Delete a position by ID'
  def destroy
    @formation_position.destroy
    head :no_content
  end

  private

  def set_formation
    @formation = Formation.find(params[:formation_id])
  end

  def set_formation_position
    @formation_position = @formation.formation_positions.find(params[:id])
  end

  def formation_position_params
    params.require(:formation_position).permit(:position_name, :position_order, :position_number)
  end
end
