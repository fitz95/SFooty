class Api::V1::StadiumsController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_stadium, only: %i[show update destroy]
  
    # GET /v1/users/:user_id/stadiums
    api :GET, '/v1/users/:user_id/stadiums', 'Get all stadiums for a specific user'
    def index
      @stadiums = @user.stadiums
      render json: @stadiums
    end
  
    # GET /v1/users/:user_id/stadiums/:id
    api :GET, '/v1/users/:user_id/stadiums/:id', 'Get a specific stadium by id'
    def show
      render json: @stadium
    end
  
    # POST /v1/users/:user_id/stadiums
    api :POST, '/v1/users/:user_id/stadiums', 'Create a new stadium'
    def create
      @stadium = @user.stadiums.new(stadium_params)
  
      if @stadium.save
        render json: @stadium, status: :created, notice: 'Stadium was successfully created.'
      else
        render json: @stadium.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /v1/users/:user_id/stadiums/:id
    api :PATCH, '/v1/users/:user_id/stadiums/:id', 'Update a stadium'
    def update
      if @stadium.update(stadium_params)
        render json: @stadium, notice: 'Stadium was successfully updated.'
      else
        render json: @stadium.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /v1/users/:user_id/stadiums/:id
    api :DELETE, '/v1/users/:user_id/stadiums/:id', 'Delete a stadium'
    def destroy
      @stadium.destroy
      render json: { message: 'Stadium deleted successfully!' }, status: :ok
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_stadium
      @stadium = @user.stadiums.find(params[:id])
    end
  
    def stadium_params
      params.require(:stadium).permit(:stadium_name, :city, :country, :capacity, :year_opened, :stadium_photo, :team_id )
    end
  end
  