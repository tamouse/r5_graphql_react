require "auth_token"

class AuthorizationError < RuntimeError; end

module AuthenticateUser
  extend ActiveSupport::Concern

  included do
    @current_user = nil
  end

  def current_user
    @current_user
  end

  def authenticate_user
    @current_user = nil
    return @current_user if request.headers['Authorization'].blank?
    token = request.headers['Authorization'].split(' ').last
    return @current_user if token.blank?
    payload = AuthToken.new.verify(token)
    uuid = payload.dig(:ok, :id)
    @current_user = User.find_by(uuid: uuid)
    return @current_user
  rescue RuntimeError => e
    raise AuthorizationError.new e.message
  end
end
