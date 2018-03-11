class Mutations::Users::LoginUserMutation
  def call(_object, args, _context)
    creds = args[:credentials]
    user = User.find_by(email: creds[:email])
    raise GraphQL::ExecutionError.new("Invalid user") until user.authenticate(creds[:password])

    OpenStruct.new({
        token: AuthToken.new.token(user),
        user: user
      })
  rescue ActbiveRecord::RecordNotFound => e
    raise GraphQL::ExecutionError.new("Invalid user")
  end
end
