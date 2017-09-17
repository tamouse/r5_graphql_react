Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  # Not responding to /graphiql, use GraphiQL tool instead
end
