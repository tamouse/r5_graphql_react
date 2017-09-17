class NullUser
  include ActiveModel::Model
  attr_accessor :id, :uuid, :name, :email, :admin
  def initialize(attributes={})
    self.id = 0
    self.uuid = ''
    self.name = ''
    self.email = ''
    self.admin = false
  end

  def persisted?
    true
  end

  def validated
    true
  end
  alias :valid? :validated

  def posts
    Post.all
  end

end
