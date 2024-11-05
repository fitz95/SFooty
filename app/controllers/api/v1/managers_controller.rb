class Api::V1::ManagersController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_manager, only: %i[show update destroy]
  
    # API Documentation for getting all managers for a user
    api :GET, '/v1/users/:user_id/managers', 'Get all managers for the user'
    def index
      @managers = @user.managers
      render json: @managers
    end
  
    # API Documentation for getting a specific manager by ID
    api :GET, '/v1/users/:user_id/managers/:id', 'Get manager with id'
    param :id, :number, desc: 'ID of the requested manager', required: true
    error code: 404, desc: 'Manager not found!'
    def show
      render json: @manager
    end
  
    # API Documentation for creating a new manager
    api :POST, '/v1/users/:user_id/managers', 'Create a new manager for this user'
    def create
      @manager = @user.managers.new(manager_params)
  
      if @manager.save
        render json: @manager, status: :created, message: 'Manager was successfully created.'
      else
        render json: @manager.errors, status: :unprocessable_entity
      end
    end
  
    # API Documentation for updating a specific manager
    api :PATCH, '/v1/users/:user_id/managers/:id', 'Update manager with id'
    def update
      if @manager.update(manager_params)
        render json: @manager, message: 'Manager was successfully updated.'
      else
        render json: @manager.errors, status: :unprocessable_entity
      end
    end
  
    # API Documentation for deleting a manager by ID
    api :DELETE, '/v1/users/:user_id/managers/:id', 'Delete manager by id'
    def destroy
      authorize! :destroy, Manager
      if @manager.destroy
        render json: { message: 'Manager deleted successfully!' }, status: :ok
      else
        render json: { error: 'Failed to delete the Manager.' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_manager
      @manager = @user.managers.find(params[:id])
    end
  
    def manager_params
      params.require(:manager).permit(:name, :date_of_birth, :nationality, :experience_level, :hired_on, :contract_end_date, :salary, :achievements, :manager_type, :previous_teams)
    end
  end
  