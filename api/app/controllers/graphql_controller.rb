class GraphqlController < ApplicationController
  include AuthenticateUser

  def execute
    authenticate!
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }

    # NOTE: For whatever reason, if you specify a blank operation_name, graphql messes up
    if operation_name.present?
      result = R5GraphqlReactSchema.execute(query,
        variables: variables, context: context, operation_name: operation_name)
    else
      result = R5GraphqlReactSchema.execute(query,
        variables: variables, context: context)
    end

    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
