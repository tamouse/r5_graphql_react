Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :uuid, types.ID
  field :name, types.String
  field :email, types.String
end
