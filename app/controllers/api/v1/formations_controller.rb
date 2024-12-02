# app/controllers/api/v1/formations_controller.rb
class Api::V1::FormationsController < ApplicationController
    before_action :authenticate_request
    before_action :set_user
    before_action :set_formation, only: %i[show update destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/formations
    api :GET, '/api/v1/users/:user_id/formations', 'Get all formations for a user'
    def index
      @formations = @user.formations
      render json: @formations
    end
  
    # GET /api/v1/users/:user_id/formations/:id
    api :GET, '/api/v1/users/:user_id/formations/:id', 'Get a specific formation by ID for a user'
    param :id, :number, desc: 'ID of the requested formation', required: true
    def show
      render json: @formation
    end
  
    # POST /api/v1/users/:user_id/formations
    api :POST, '/api/v1/users/:user_id/formations', 'Create a new formation for a user'
    def create
      @formation = @user.formations.new(formation_params)
      if @formation.save
        render json: @formation, status: :created
      else
        render json: @formation.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/formations/:id
    api :PATCH, '/api/v1/users/:user_id/formations/:id', 'Update an existing formation by ID for a user'
    def update
      if @formation.update(formation_params)
        render json: @formation
      else
        render json: @formation.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/formations/:id
    api :DELETE, '/api/v1/users/:user_id/formations/:id', 'Delete a formation by ID for a user'
    def destroy
      @formation.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_formation
      @formation = @user.formations.find(params[:id])
    end
  
    def formation_params
      params.require(:formation).permit(:formation_name, :description)
    end
  end
  