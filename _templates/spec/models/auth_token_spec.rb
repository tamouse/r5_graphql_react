require "rails_helper"

RSpec.describe AuthToken do

  let(:user) { double("user", uuid: SecureRandom.uuid) }

  it "produces a token" do
    expect(subject.token(user)).not_to be_nil
  end

  it "verifies a token" do
    token = subject.token(user)
    expect(subject.verify(token)).not_to be_nil
  end

  it "returns the right payload" do
    token = subject.token(user)
    result = subject.verify(token)
    expect(result.dig(:ok, :id)).to eq(user.uuid)
  end
end
