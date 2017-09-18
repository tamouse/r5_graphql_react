class Mutations::LoginUser
  def call(_, args, _)
    creds = args[:credentials]
    user = User.find_by(email: creds[:email])
    raise GraphQL::ExecutionError.new("Invalid user") until user.authenticate(creds[:password])

    OpenStruct.new({
        token: AuthToken.new.token(user),
        user: user
      })
  rescue ActiveRecord::RecordNotFound => e
    raise GraphQL::ExecutionError.new("Invalid user")
  end
end
