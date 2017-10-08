# This are examples of graphql mutations for the following mutation types
GRAPHQL_CANONICAL_MUTATIONS = {
  createUser: 'mutation SignUpUser($credentials: AuthProviderCredentials) {
    createUser(credentials: $credentials)
    {token user {id name email}}
  }',

  loginUser: 'mutation LogInUser($credentials: AuthProviderCredentials) {
    loginUser(credentials: $credentials)
    {token user {id name email}}
  }',

  createPost: 'mutation CreatePost($post_parameters: PostInput!)
  { createPost(post_parameters: $post_parameters)
    { id title excerpt body publishedAt author { name } comment_count }
  }',
}

Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  # USERS

  field :createUser, Types::AuthenticateType do
    description "Creates a new user"
    argument :credentials, Types::AuthProviderCredentialsType
    resolve Mutations::Users::CreateUserMutation.new
  end

  field :loginUser, Types::AuthenticateType do
    description "Logs in a user"
    argument :credentials, Types::AuthProviderCredentialsType
    resolve Mutations::Users::LoginUserMutation.new
  end

  # POSTS

  field :createPost, Types::PostType do
    description "Create a New Post"
    argument :post_parameters, Types::PostInputType
    resolve Mutations::Posts::CreatePostMutation.new
  end

  # ... and so on

end
