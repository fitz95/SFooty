class Api::V1::MatchLineupsController < ApplicationController
  before_action :authenticate_request
  before_action :set_user
  before_action :set_match
  before_action :set_match_lineup, only: %i[show update destroy]
  load_and_authorize_resource

  # GET /api/v1/users/:user_id/matches/:match_id/match_lineups
  def index
    @lineups = @match.match_lineups
    render json: @lineups
  end

  # GET /api/v1/users/:user_id/matches/:match_id/match_lineups/:id
  def show
    render json: @match_lineup
  end

  # POST /api/v1/users/:user_id/matches/:match_id/match_lineups
  def create
    @lineup = @match.match_lineups.new(lineup_params)
    @lineup.user_id = @user.id

    if @lineup.save
      render json: @lineup, status: :created
    else
      render json: @lineup.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/:user_id/matches/:match_id/match_lineups/:id
  def update
    if @match_lineup.update(lineup_params)
      render json: @match_lineup
    else
      render json: @match_lineup.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/:user_id/matches/:match_id/match_lineups/:id
  def destroy
    @match_lineup.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_match
    @match = @user.matches.find(params[:match_id])
  end

  def set_match_lineup
    @match_lineup = @match.match_lineups.find(params[:id])
  end

  def lineup_params
    params.require(:match_lineup).permit(:formation_id, :team_id, :expected_match_lineup, :lineup_name, :comments)
  end
end

