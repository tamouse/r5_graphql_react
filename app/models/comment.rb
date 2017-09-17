class Comment < ApplicationRecord
  include EnsureUUID

  belongs_to :author, class_name: "User", foreign_key: :user_id
  belongs_to :post

  validates_presence_of :body, :author, :post
end
