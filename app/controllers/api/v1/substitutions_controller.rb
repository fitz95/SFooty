class Api::V1::SubstitutionsController < ApplicationController
    before_action :authenticate_request
    before_action :set_user
    before_action :set_match
    before_action :set_substitution, only: %i[show update destroy]
    load_and_authorize_resource
  
    # GET /api/v1/users/:user_id/matches/:match_id/substitutions
    def index
      @substitutions = @match.substitutions
      render json: @substitutions
    end
  
    # GET /api/v1/users/:user_id/matches/:match_id/substitutions/:id
    def show
      render json: @substitution
    end
  
    # POST /api/v1/users/:user_id/matches/:match_id/substitutions
    def create
      @substitution = @match.substitutions.new(substitution_params)
      @substitution.user_id = @user.id
  
      if @substitution.save
        render json: @substitution, status: :created
      else
        render json: @substitution.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/substitutions/:id
    def update
      if @substitution.update(substitution_params)
        render json: @substitution
      else
        render json: @substitution.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/users/:user_id/matches/:match_id/substitutions/:id
    def destroy
      @substitution.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_match
      @match = Match.find(params[:match_id])
    end
  
    def set_substitution
      @substitution = @match.substitutions.find(params[:id])
    end
  
    def substitution_params
      params.require(:substitution).permit(:player_in_id, :player_out_id, :minute, :team_id)
    end
  end
  