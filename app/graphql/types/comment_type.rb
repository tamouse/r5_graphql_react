Types::CommentType = GraphQL::ObjectType.define do
  name "Comment"
  field :uuid, types.ID
  field :excert, types.String do
    resolve ->(ojb, _a, _c) {obj.body.truncate(40, separator: ' ')}
  end
  field :body, types.String
  field :author, Types::UserType
  field :post, Types::PostType
  field :createdAt, types.String do
    resolve ->(obj, _a, _c) {obj.created_at.iso8601(6)}
  end
  field :updatedAt, types.String do
    resolve ->(obj, _a, _c) {obj.updated_at.iso8601(6)}
  end
end
