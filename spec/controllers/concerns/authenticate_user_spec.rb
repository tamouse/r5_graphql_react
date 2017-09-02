require "rails_helper"
require "auth_token"
require "ostruct"

class FakeController
  include AuthenticateUser
  attr_accessor :request
  def initialize
    @request = OpenStruct.new(headers: {})
  end
end

RSpec.describe "AuthenticateUser Concern" do
  subject { FakeController.new }

  let(:user) { FactoryGirl.create(:user) }
  let(:token) { AuthToken.new.token(user) }

  it "can call :authenticate_user" do
    expect(subject).to respond_to(:authenticate_user)
  end

  it "can call :current_user" do
    expect(subject).to respond_to(:current_user)
  end

  it "can authenticate" do
    subject.request.headers['Authorization'] = "Bearer #{token}"
    expect(subject.authenticate_user).to eq(user)
  end

  it "current user" do
    subject.request.headers['Authorization'] = "Bearer #{token}"
    subject.authenticate_user
    expect(subject.current_user).to eq(user)
  end

  it "returns nil when no Authorization header given" do
    expect(subject.authenticate_user).to be_nil
  end

  it "returns nil current user when no Authorization header given" do
    expect(subject.current_user).to be_nil
  end

  it "throws an error when given a bad token" do
    subject.request.headers['Authorization'] = 'Bearer bad-token'
    expect{subject.authenticate_user}.to raise_error(AuthorizationError)
  end

  it "treats invalid token as nil user" do
    fake_user = OpenStruct.new(uuid: "bad uuid")
    bad_token = AuthToken.new.token(fake_user)
    subject.request.headers['Authorization'] = "Bearer #{bad_token}"
    expect(subject.authenticate_user).to be_nil
    expect(subject.current_user).to be_nil
  end

end
