class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request
  # load_and_authorize_resource
  api :GET, '/v1/users', 'Get all users'
  error code: 404, desc: 'Users not found!'
  def index
    @users = if current_user.role == 'admin' || current_user.role == 'super_admin'
               User.all
             else
               [current_user]
             end

    if @users.empty?
      render json: { error: 'No users found.' }, status: :unprocessable_entity
    else
      render json: @users
    end
  end

  api :GET, '/v1/users/:id', 'Get user with id'
  param :id, :number, desc: 'id of the requested user', required: true
  error code: 404, desc: 'User not found!'
  def show
    @user = User.find_by(id: params[:id])
    if @user.present? && (
      current_user.role == 'admin'||
      current_user.role == 'super_admin' ||
      @user.id == current_user.id
      )
      render json: @user
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  api :DELETE, '/v1/users/:id', 'Delete user by id'
  param :id, :number, desc: 'id of the requested user', required: true
  error code: 404, desc: 'User not found!'
  def destroy
    authorize! :destroy, User
    @user = User.find_by(id: params[:id])

    # check if the user exists
    unless @user
      render json: { error: 'User not found!' }, status: :not_found
      return
    end

    # Authorize the current user to destroy the specified user

    if current_user.role == 'admin' || current_user == @user
      if @user.destroy
        render json: { message: 'User deleted successfully!' }, status: :ok
      else
        render json: { error: 'Failed to delete the User.' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized to delete this user.' }, status: :unauthorized
    end
  end
end
