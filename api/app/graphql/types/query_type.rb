Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  field :viewer, Types::ViewerType, "Viewer of data, may be an anonymous user or registered user" do
    resolve ->(_object, _args, context) do
      if context[:current_user].present?
        context[:current_user]
      else
        NullUser.new
      end
    end
  end
end
