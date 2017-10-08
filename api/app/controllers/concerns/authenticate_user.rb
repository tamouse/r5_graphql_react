require "auth_token"

module AuthenticateUser
  Error = Class.new(RuntimeError)
  InvalidHeader = Class.new(Error)
  InvalidUser = Class.new(Error)
  TokenExpired = Class.new(Error)

  extend ActiveSupport::Concern

  included do
    @current_user = nil
  end

  def current_user
    @current_user
  end

  def authenticate!
    if auth_header.blank? or auth_header == 'null'
      @current_user = nil
      return true
    end

    # if  auth_token.present? &&
    #     auth_payload.present? &&
    #     auth_ok? &&
    #     ! auth_expired?
    # then
    #   @current_user = User.find_by(uuid: auth_payload.dig(:ok, :id))
    # else
    #   raise TokenExpired.new "token expired" if auth_expired?
    #   raise InvalidHeader.enw "invalid header" unless auth_token.present?
    #   raise InvalidUser.new "invalid user"
    # end

    raise InvalidHeader.new "invalid header" unless auth_token.present?
    raise TokenExpired.new "token expired" if auth_expired?
    raise Error.new "other error: #{auth_payload}" unless auth_ok?

    @current_user = User.find_by(uuid: auth_payload.dig(:ok, :id))

    true
  end

  private

  def auth_header
    @_auth_header ||= request.headers["Authorization"]
  end

  def auth_token
    @_auth_token ||= auth_header.split(" ")[1].tap do |t|
      raise InvalidHeader.new "missing token" if t.nil?
    end
  end

  def auth_payload
    @_auth_payload ||= AuthToken.new.verify(auth_token)
  end

  def auth_ok?
    !! auth_payload.dig(:ok)
  end

  def auth_expired?
    !! (auth_payload.dig(:error) == :token_expired)
  end

end
