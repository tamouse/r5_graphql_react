class Post < ApplicationRecord
  include EnsureUUID

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates_presence_of :user, :title, :body

  scope :published, -> { where.not(published_at: nil) }
  scope :drafts, -> { where(published_at: nil) }

  def published?
    !!published_at.nil?
  end

  def publish!
    self.update(published_at: Time.current)
  end

end
