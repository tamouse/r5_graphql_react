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

  def can_post?
    false
  end

  def method_missing(method_id)
    null
  end

  def respond_to?(method_id)
    User.new.respond_to? method_id
  end

end
