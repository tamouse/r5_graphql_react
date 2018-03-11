Types::ViewerType = GraphQL::ObjectType.define do
  name "Viewer"
  field :self, Types::UserType, "My User Record" do
    resolve ->(object, _a, _c) { object }
  end

  connection :my_posts, Edges::PostsWithPagination do
    argument :ids, types.String
    argument :title_contains, types.String
    argument :since, types.String
    argument :published_only, types.Boolean
    argument :drafs_only, types.Boolean
    argument :sort_by, types.String
    argument :direction, types.String
    argument :page, types.Int
    argument :per_page, types.Int
    resolve Resolvers::PostsResolver.new( ->(o,a,c) {o.posts} )
  end

  connection :public_posts, Edges::PostsWithPagination do
    argument :ids, types.String
    argument :title_contains, types.String
    argument :since, types.String
    argument :published_only, types.Boolean
    argument :drafs_only, types.Boolean
    argument :sort_by, types.String
    argument :direction, types.String
    argument :page, types.Int
    argument :per_page, types.Int
    resolve Resolvers::PostsResolver.new( ->(o,a,c) { Post.published })
  end

  connection :all_authors, Edges::UsersWithPagination do
    resolve ->(_object, _a, _c) { User.all }
  end
end
