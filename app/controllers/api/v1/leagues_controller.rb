class Api::V1::LeaguesController < ApplicationController
    before_action :authenticate_request
    load_and_authorize_resource
    before_action :set_user
    before_action :set_league, only: %i[show edit update destroy]

    api :GET, '/v1/users/:user_id/leagues', 'Get all leagues'
    def index
        @leagues = @user.leagues
        render json: @leagues
    end 

    api :GET, '/v1/users/:user_id/leagues/:id', 'Get league with id'
    def show
        render json: @league
    end

    api :GET '/v1/users/:user_id/leagues/new', 'Create a new league'
    def new
        @league = @user.leagues.new
    end

    api :GET, '/v1/users/:user_id/leagues/:id/edit', 'Edit league with id'
    def edit
    end
    
    api :POST, '/v1/users/:user_id/leagues', 'Create a new league'
    def create
        @league = @user.leagues.new(league_params)

        if @league.save
            render json: @league, notice: 'League was successfully created.'
        else
            render json: @league.errors, status: :unprocessable_entity
        end
    end

    api :PATCH, '/v1/users/:user_id/leagues/:id', 'Update league with id'
    def update
        if @league.update(league_params)
            redirect_to user


end
