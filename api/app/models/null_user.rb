class NullUser

  include ActiveModel::Model
  attr_accessor :null_user

  delegate_missing_to :null_user

  def initialize(attributes={})
    self.null_user = User.new(
      id: -1,
      uuid: '',
      name: '',
      email: '',
      admin: false,
    )
    self.null_user.id = -1
  end

  def can_post?
    false
  end

end
