class Mutations::Users::CreateUserMutation
  def call(obj, args, ctx)
    creds = args[:credentials]
    user = User.create!(
      name: creds[:name],
      email: creds[:email],
      password: creds[:password],
      password_confirmation: creds[:password]
      )
    OpenStruct.new({
        token: AuthToken.new.token(user),
        user: user
      })
  rescue ActiveRecord::RecordInvalid => e
    raise GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
