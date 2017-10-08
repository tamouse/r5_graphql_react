Types::AuthProviderCredentialsType = GraphQL::InputObjectType.define do
  name "AuthProviderCredentials"
  argument :name, types.String
  argument :email, !types.String
  argument :password, !types.String
end
