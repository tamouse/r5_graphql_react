require "uuid"

# See https://github.com/assaf/uuid#uuid-state-file
UUID.state_file = false
UUID.generator.next_sequence
