require "uuid"

module EnsureUUID

  extend ActiveSupport::Concern

  included do
    before_validation :create_uuid
  end

  def create_uuid
    unless self.uuid.present?
      self.uuid = UUID.new.generate
    end
  end

end
