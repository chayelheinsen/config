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
        request.headers["Authorization"].split(" ").last
      end
  end

  def raise_auth_error
    raise(APIKeyAuthenticatable::Error)
  end

  private

  def find_by_api_token
    return if http_api_token.nil?
    APIKey.authenticate_by_token!(http_api_token)
  rescue
    nil
  end
end