Types::PostInputType = GraphQL::InputObjectType.define do
  name "PostInput"
  argument :title, !types.String, "Title for post (required)"
  argument :body, !types.String, "Contents of post (required)"
  argument :published_at, types.String, "Publication date (optional)"
end
