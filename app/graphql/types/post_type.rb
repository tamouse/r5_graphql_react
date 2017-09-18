Types::PostType = GraphQL::ObjectType.define do
  name "Post"
  field :id, types.ID do
    resolve ->(o, _, _) {o.uuid}
  end
  field :title, types.String
  field :excerpt, types.String, "Short excerpt from body" do
    resolve ->(obj, _args, _ctx) {
      obj.body.truncate(40, separator: ' ')
    }
  end
  field :body, types.String
  field :publishedAt, types.String do
    resolve ->(o, _a, _c) {o.published_at.iso8601(6) if o.published_at}
  end
  field :createdAt, types.String do
    resolve ->(o, _a, _c) {o.created_at.iso8601(6)}
  end
  field :updatedAt, types.String do
    resolve ->(o, _a, _c) {o.updated_at.iso8601(6)}
  end

  field :author, Types::UserType
  field :comments, types[Types::CommentType]
end
