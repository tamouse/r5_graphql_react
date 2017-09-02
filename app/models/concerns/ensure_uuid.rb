require "uuid"

module EnsureUUID

  extend ActiveSupport::Concern

  included do
    before_validation :set_uuid
    validates_uniqueness_of :uuid
  end

  def set_uuid
    unless self.uuid.present?
      self.uuid = UUID.new.generate
    end
  end

end
