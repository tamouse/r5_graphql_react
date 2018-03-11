module Resolvers
  class TimeFieldFormatter
    def initialize(field)
      @field = field
    end

    def call(object, _args, _context)
      time_field = object.public_send(@field)
      time_field.utc.iso8601(6) if time_field
    end
  end
end
