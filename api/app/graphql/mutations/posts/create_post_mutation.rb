class Mutations::Posts::CreatePostMutation

  def call(_obj, args, context)

    current_user = context[:current_user]

    if current_user.can_post?
      params = ActionController::Parameters.new(args.to_h)
      post_parameters = params.require(:post_parameters).permit(:title, :body, :published_at)
      post = current_user.posts.create!(post_parameters)
    else
      msg = "Not authorized"
      raise GraphQL::ExecutionError.new(msg)
    end

  rescue ActiveRecord::RecordInvalid => e

    if e.respond_to? :record
      msg = "Invalid input: #{e.record.errors.full_messages.join(', ')}"
    else
      msg = "Invalid operation: #{e}"
    end
    raise GraphQL::ExecutionError.new(msg)

  end

end
