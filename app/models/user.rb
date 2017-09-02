require 'uuid'

class User < ApplicationRecord
  include EnsureUUID

  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email

end
