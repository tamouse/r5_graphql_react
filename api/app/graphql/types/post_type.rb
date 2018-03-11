Types::PostType = GraphQL::ObjectType.define do
  name "Post"
  field :id, types.ID, hash_key: :uuid
  field :db_row_id, types.Int, hash_key: :id
  field :title, types.String
  field :excerpt, types.String, "Short excerpt from body" do
    resolve ->(obj, _args, _ctx) {
      obj.body.truncate(40, separator: ' ')
    }
  end
  field :body, types.String

  %w[created_at updated_at published_at].each do |field|
    field field.to_sym, types.String do
      resolve Resolvers::TimeFieldFormatter.new(field.to_sym)
    end
    field "#{field}_ms", types.Int do
      # Using a resolve wrapper: http://graphql-ruby.org/fields/resolve_wrapper.html``
      resolve Resolvers::TimeFieldMillisecond.new( ->(obj, args, ctx) { obj.public_send(field) } )
    end
  end

  field :comment_count, types.Int, "Number of comments on post" do
    resolve ->(o,_a,_c){o.comments.count}
  end

  field :author, Types::UserType
  field :comments, types[Types::CommentType]
end
