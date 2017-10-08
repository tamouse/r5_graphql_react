require "rails_helper"

RSpec.describe Mutations::Posts::CreatePostMutation do

  before do
    @chema = R5GraphqlReactSchema
    @user = FactoryGirl.create(:user)
    @null_user = NullUser.new
    @context = OpenStruct.new(current_user: @user)
  end

  it "creates a new post" do
    prior_post_count = Post.count
    mutation = GRAPHQL_CANONICAL_MUTATIONS[:createPost]
    variables = {
      "post_parameters" => FactoryGirl.attributes_for(:post)
    }.with_indifferent_access
    op_name = 'CreatePost'

    result = R5GraphqlReactSchema.execute(
      mutation,
      variables: variables,
      context: @context,
      operation_name: op_name
      )

    expect(result.dig('errors')).to be_nil, result.inspect
    after_post_count = Post.count
    expect(after_post_count - prior_post_count).not_to be_zero

    # result should have the data
    expect(result.keys).to eq(%w[data])
    new_post_id = result.dig('data','createPost','id')
    new_post = Post.find_by(uuid: new_post_id)
    expect(new_post).not_to be_nil

  end

end
