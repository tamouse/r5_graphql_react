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

  describe "check expiry" do

    context "when token has not expired" do
      it "payload is ok" do
        Timecop.freeze(Time.new(2017,9,4,11,00).utc) do
          token = subject.token(user)
          expect(subject.verify(token).dig(:ok)).to be_truthy
        end
      end
    end

    context "when token has expired" do
      it "payload is an error" do
        Timecop.freeze(Time.new(2017,9,4,11,00).utc) do
          token = subject.token(user)
          Timecop.freeze(Time.now + 2.hours) do
            expect(subject.verify(token).dig(:ok)).not_to be_truthy
          end
        end
      end
    end

  end

end
