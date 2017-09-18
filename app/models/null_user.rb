class NullUser
  include ActiveModel::Model
  attr_accessor :id, :uuid, :name, :email, :admin
  def initialize(attributes={})
    self.id = 0
    self.uuid = ''
    self.name = 'Null User'
    self.email = 'null'
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
    []
  end

  def comments
    []
  end

end
