class Comment < ApplicationRecord
  include EnsureUUID

  belongs_to :user
  belongs_to :post

  validates_presence_of :body, :user, :post
end
