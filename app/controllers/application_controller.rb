class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_request, except: %i[sign_in sign_up create update]

  attr_reader :current_user

  def authenticate_request
    @current_user = authorize_token
    return if @current_user

    Rails.logger.debug "Authentication failed: No current user found"
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def authorize_token
    token = extract_token
    Rails.logger.debug "Extracted Token: #{token}"

    return unless token

    if revoked_token?(token)
      Rails.logger.debug "Token is revoked: #{token}"
      @current_user = nil
      return
    end

    decoded_token = decode_token(token)
    Rails.logger.debug "Decoded Token: #{decoded_token.inspect}"

    User.find_by(id: decoded_token['sub']) if decoded_token
  rescue JWT::DecodeError
    nil
  end

  def extract_token
    header = request.headers['Authorization']
    header&.split&.last
  end

  def decode_token(token)
    @decode_token = JWT.decode(token, ENV.fetch('JWT_SECRET', nil), true, algorithm: 'HS256').first
  end

  def revoked_token?(token)
    RevokedToken.exists?(token:)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[username first_name last_name email role user_photo])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username role user_photo])

    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:username, :email)
    end
  end

  #extra authorization error catch as well as redirection
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "You are not authorized to perform this task"
    render json: { error: exception.message }, status: :forbidden
  end
end
