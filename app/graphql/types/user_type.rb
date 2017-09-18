Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID, hash_key: :uuid
  field :name, types.String
  field :email, !types.String

  field :posts, types[Types::PostType]
end
