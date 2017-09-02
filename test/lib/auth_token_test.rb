require "test_helper"
require "ostruct"
require "auth_token"

class AuthTokenTest < Minitest::Test

  def setup
    @user = OpenStruct.new(uuid: "12345")
    @authzor = ::AuthToken.new
  end

  def test_auth_token_with_jwt
    token = @authzor.token(@user)
    refute_nil token
    res = @authzor.verify(token)
    assert_equal @user.uuid, res.dig(:ok, :id)
  end

end
