require "json_web_token"

class AuthToken

  def initialize()
    @sekrit = Rails.application.secrets.secret_key_base
  end

  def token(user)
    payload = { id: user.uuid }
    JsonWebToken.sign(payload, key: @sekrit)
  end

  def verify(token)
    res = JsonWebToken.verify(token, key: @sekrit)
  end

end
