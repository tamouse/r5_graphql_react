require "test_helper"
require "auth_token"
require "ostruct"

class FakeController
  include AuthenticateUser
  attr_accessor :request
  def initialize
    @request = OpenStruct.new(headers: {})
  end
end

class AuthenticateUserTest < Minitest::Test

  def setup
    @fake_controller = FakeController.new
    @user = FactoryGirl.create(:user)
    @token = AuthToken.new.token(@user)
  end

  def teardown
    @user.destroy
  end

  def test_controller_can_call_authenticate_user
    assert @fake_controller.respond_to? :authenticate_user
  end

  def test_controller_can_call_current_user
    assert @fake_controller.respond_to? :current_user
  end

  def test_can_authentiate
    @fake_controller.request.headers['Authorization'] = "Bearer #{@token}"
    assert_equal @user, @fake_controller.authenticate_user
  end

  def test_current_user
    @fake_controller.request.headers['Authorization'] = "Bearer #{@token}"
    refute_nil @fake_controller.authenticate_user
    assert_equal @user, @fake_controller.current_user
  end

  def test_no_header
    assert_nil @fake_controller.authenticate_user
  end

  def test_bad_token
    @fake_controller.request.headers['Authorization'] = 'Bearer bad-token'
    assert_raises AuthorizationError do
      @fake_controller.authenticate_user
    end
  end

  def test_invalid_token
    fake_user = OpenStruct.new(uuid: "bad uuid")
    bad_token = AuthToken.new.token(fake_user)
    @fake_controller.request.headers['Authorization'] = "Bearer #{bad_token}"
    assert_nil @fake_controller.authenticate_user
    assert_nil @fake_controller.current_user
  end


end
