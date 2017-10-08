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

  it "can call :authenticate!" do
    expect(subject).to respond_to(:authenticate!)
  end

  it "can call :current_user" do
    expect(subject).to respond_to(:current_user)
  end

  it "can authenticate" do
    subject.request.headers['Authorization'] = "Bearer #{token}"
    expect(subject.authenticate!).to be_truthy
    expect(subject.current_user).to eq(user)
  end

  it "succeeds when no Authorization header given, current user is nil" do
    expect(subject.authenticate!).to be_truthy
    expect(subject.current_user).to be_nil
  end

  it "raises InvalidHeader when no actual token present" do
    subject.request.headers['Authorization'] = 'Bearer'
    expect{subject.authenticate!}.to raise_error(AuthenticateUser::InvalidHeader)
  end

  it "raises Error when given a bad token" do
    subject.request.headers['Authorization'] = 'Bearer bad-token'
    expect{subject.authenticate!}.to raise_error(AuthenticateUser::Error)
  end

  it "raises TokenExpired when token is out of date" do
    allow_any_instance_of(AuthToken).to receive(:verify).and_return({error: :token_expired})
    subject.request.headers['Authorization'] = "Bearer #{token}"

    expect{subject.authenticate!}.to raise_error(AuthenticateUser::TokenExpired)
  end
end
