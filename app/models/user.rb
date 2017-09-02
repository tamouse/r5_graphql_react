require 'uuid'

class User < ApplicationRecord

  has_secure_password
  before_validation :create_uuid_for_user

  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email

  def create_uuid_for_user
    unless self.uuid.present?
      self.uuid = UUID.new.generate
    end
  end
end
