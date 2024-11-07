# app/controllers/api/v1/competitions_controller.rb
class Api::V1::CompetitionsController < ApplicationController
    before_action :authenticate_request
    before_action :set_user
    before_action :set_competition, only: %i[show update destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/competitions
    api :GET, '/api/v1/users/:user_id/competitions', 'Get all competitions for a user'
    def index
      @competitions = @user.competitions
      render json: @competitions
    end
  
    # GET /api/v1/users/:user_id/competitions/:id
    api :GET, '/api/v1/users/:user_id/competitions/:id', 'Get a competition by id for a user'
    param :id, :number, desc: 'ID of the requested competition', required: true
    error code: 404, desc: 'Competition not found!'
    def show
      render json: @competition
    end
  
    # POST /api/v1/users/:user_id/competitions
    api :POST, '/api/v1/users/:user_id/competitions', 'Create a new competition for a user'
    def create
      @competition = @user.competitions.new(competition_params)
  
      if @competition.save
        render json: @competition, status: :created
      else
        render json: @competition.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH /api/v1/users/:user_id/competitions/:id
    api :PATCH, '/api/v1/users/:user_id/competitions/:id', 'Update a competition by id for a user'
    def update
      if @competition.update(competition_params)
        render json: @competition
      else
        render json: @competition.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/competitions/:id
    api :DELETE, '/api/v1/users/:user_id/competitions/:id', 'Delete a competition by id for a user'
    def destroy
      @competition.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_competition
      @competition = @user.competitions.find(params[:id])
    end
  
    def competition_params
      params.require(:competition).permit(:name, :start_date, :end_date, :status, :location, :description)
    end
  end
  
