# Implement as a resolve wrapper: http://graphql-ruby.org/fields/resolve_wrapper.html

module Resolvers
  class TimeFieldMillisecond
    def initialize(resolver)
      @resolver = resolver
    end

    def call(object, args, context)
      time_field = @resolver.call(object, args, context)
      (time_field.to_f * 1000).to_i if time_field
    end
  end
end
