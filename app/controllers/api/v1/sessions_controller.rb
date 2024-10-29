class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: :destroy
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  respond_to :json

  # POST /api/v1/sign_in
  api :POST, '/v1/users/sign_in', 'Sign in user'
  param :user, Hash, desc: 'User info', required: true do
    param :login, String, desc: 'User email or username', required: true
    param :password, String, desc: 'User password', required: true
  end
  error code: 401, desc: 'Invalid email/username or password'

  def create
    login = params[:user][:login]
    resource = User.find_for_database_authentication(email: login) ||
               User.find_for_database_authentication(username: login)

    return invalid_login_attempt unless resource
    Rails.logger.info("JWT_SECRET: #{ENV['JWT_SECRET']}")
    Rails.logger.info("JWT_SECRET: #{ENV['JWT_SECRET']}")



    if resource.valid_password?(params[:user][:password])
      sign_in(resource_name, resource)

      # Generate or fetch the JWT token
      token = request.env['warden-jwt_auth.token'] || generate_jwt_token(resource)

      # Update the user's token in the database

      resource.update(authentication_token: token)
      render json: { user: resource, token: token }, status: :created and return
    end

    invalid_login_attempt
  end

  # DELETE /api/v1/sign_out
  api :DELETE, '/v1/users/sign_out', 'Sign out user'
  error code: 422, desc: 'Invalid token'
  def destroy
    token = request.headers['Authorization'].to_s.gsub('Bearer ', '')
    user = User.find_by(authentication_token: token)

    if user.present?
      user.clear_jwt_token
      user.update(authentication_token: nil)
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      logger.debug "Invalid token provided during logout: #{token} "
      render json: { error: 'Invalid token' }, status: :unprocessable_entity
    end
  end

  protected

  def jwt_revoked?(_payload, token)
    RevokedToken.exists?(token: token)
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: { error: 'Invalid email/username or password' }, status: :unauthorized
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end

  private

  def generate_jwt_token(resource)
    payload = { sub: resource.id, exp: 36.hours.from_now.to_i }
    JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
  end
end
