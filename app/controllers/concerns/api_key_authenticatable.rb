module APIKeyAuthenticatable
  extend ActiveSupport::Concern
 
  class Error < StandardError
  end

  def authenticate_with_token!
    find_by_api_token || raise_auth_error
  end

  def http_api_token
    @http_api_token ||=
      if request.headers["Authorization"].present?
        request.headers["Authorization"].split("Bearer").last
      end
  end

  def raise_auth_error
    raise(Authentication::Error)
  end

  private

  def api_token
    @api_token ||= APIKey.authenticate_by_token!(http_api_token)
  end

  def find_by_api_token
    return if api_token.nil?
    APIKey.authenticate_by_token!(api_token)
  rescue
    nil
  end
end