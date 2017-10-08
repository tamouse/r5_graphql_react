Types::ViewerType = GraphQL::ObjectType.define do
  name "Viewer"
  field :id, !types.ID, hash_key: :uuid
  field :name, !types.String
  field :email, !types.String
  field :my_posts, types[Types::PostType] do
    resolve ->(obj, _, _) { obj.posts }
  end

  field :public_posts, types[Types::PostType] do
    resolve ->(_,_,_){ Post.all }
  end
  field :all_authors, types[Types::UserType] do
    resolve ->(_,_,_){ User.all }
  end
end
