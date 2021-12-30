class API::APIController < ActionController::API
  # include Authentication
  # include ActionController::HttpAuthentication::Token::ControllerMethods

  # rescue_from Authentication::Error, with: :render_auth_error

  before_action :set_default_response_format

  def render_errors(errors, status: 422)
    render json: { errors: errors }, status: status
  end

  def render_auth_error
    render_errors("Not authenticated", status: 401)
  end

  protected

  def set_default_response_format
    request.format = :json
  end
end
