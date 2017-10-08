require "rails_helper"

RSpec.describe Mutations::Users::CreateUserMutation do

  describe "creates a new user" do
    before do
      @user_count_before = User.count
      @credentials = FactoryGirl.attributes_for(:user).with_indifferent_access
      @result = R5GraphqlReactSchema.execute(
        GRAPHQL_CANONICAL_MUTATIONS[:createUser],
        variables: {
          credentials: @credentials
        }.with_indifferent_access,
        context: {
          current_user: NullUser.new
        })

    end

    let!(:credentials) {@credentials}
    let!(:result) {@result}

    it "does not return errors" do
      expect(@result.dig('errors')).to be_nil
    end

    it "increases the user count" do
      user_count_after = User.count
      expect(user_count_after - @user_count_before).not_to be_zero
    end

    it "returns the correct user name" do
      expect(@result.dig('data', 'createUser', 'user', 'name')).to eq(@credentials['name'])
    end

    it "returns the correct user email" do
      expect(@result.dig('data', 'createUser', 'user', 'email')).to eq(@credentials['email'])
    end

    it "creates the user correctly" do
      new_user_id = @result.dig('data', 'createUser', 'user', 'id')
      new_user = User.find_by(uuid: new_user_id)
      aggregate_failures do
        expect(new_user).to be_present, result.inspect
        expect(new_user.name).to eq(@credentials['name'])
        expect(new_user.email).to eq(@credentials['email'])
      end
    end

    it "returns a valid token" do
      token = @result.dig('data', 'createUser', 'token')
      expect(AuthToken.new.verify(token).keys).to eq([:ok])
    end

    it "token matches user" do
      token = @result.dig('data', 'createUser', 'token')
      payload = AuthToken.new.verify(token)
      user_id = @result.dig('data', 'createUser', 'user', 'id')
      expect(payload.dig(:ok, :id)).to eq(user_id)
    end


  end

end
