Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :uuid, types.ID
  field :name, types.String
  field :email, types.String

  field :posts, types[Types::PostType]
  field :authors, types[Types::UserType] do
    resolve ->(_o, _a, _c) {User.all}
  end
end
