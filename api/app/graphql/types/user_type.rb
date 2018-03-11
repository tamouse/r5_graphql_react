Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID, hash_key: :uuid
  field :db_row_id, types.Int, hash_key: :id
  field :name, types.String
  field :email, !types.String

  connection :posts, Edges::PostsWithPagination do
    argument :ids, types.String
    argument :title_contains, types.String
    argument :since, types.String
    argument :published_only, types.Boolean
    argument :drafs_only, types.Boolean
    argument :sort_by, types.String
    argument :direction, types.String
    argument :page, types.Int
    argument :per_page, types.Int
    resolve Resolvers::PostsResolver.new( ->(o, a, c) { o.posts } )
  end
end
