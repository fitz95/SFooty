class Api::V1::MatchOfficialsController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_match_official, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/match_officials', 'Get all match_officials'
    def index
        render json: @match_officials
    end 

    api :GET, '/v1/users/:user_id/match_officials/:id', 'Get match_official with id'
    def show
        render json: @match_official
    end

    api :GET, '/v1/users/:user_id/match_officials/new', 'Create a new match_official'
    def new
        @match_official = @user.match_officials.new
    end

    api :GET, '/v1/users/:user_id/match_officials/:id/edit', 'Edit match_official with id'
    def edit
    end
    
    api :POST, '/v1/users/:user_id/match_officials', 'Create a new match_official'
    def create
        @match_official = @user.match_officials.new(match_official_params)

        if @match_official.save
            render json: @match_official, notice: 'match_official was successfully created.'
        else
            render json: @match_official.errors, status: :unprocessable_entity
        end
    end

    api :PATCH, '/v1/users/:user_id/match_officials/:id', 'Update match_official with id'
    def update
        if @match_official.update(match_official_params)
            render json: @match_official, notice: 'match_official was successfully updated.'
        else
            render json: @match_official.errors, status: :unprocessable_entity
        end
    end 

    api :DELETE, '/v1/users/:user_id/match_officials/:id', 'Delete match_official by id'
    def destroy
        authorize! :destroy, match_official
        @match_official = match_official.find_by(id: params[:id])
        if @match_official.destroy
            render json: { message: 'match_official deleted successfully!' }, status: :ok
        else
            render json: { error: 'Failed to delete the match_official.' }, status: :unprocessable_entity
        end
    end

    private
    
    def set_user
        @user = User.find(params[:user_id])
    end
    def set_match_official
        @match_official = MatchOfficial.find(params[:id])
    end

    def match_official_params
        params.require(:match_official).permit(:first_name, :last_name, :nationality, :date_of_birth, :official_photo)
    end
end
