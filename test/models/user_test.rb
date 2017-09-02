require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user requires name, email, and password" do
    user = User.new()
    refute user.validate
    assert_includes user.errors.full_messages, "Name can't be blank"
    assert_includes user.errors.full_messages, "Email can't be blank"
    assert_includes user.errors.full_messages, "Password can't be blank"
    assert_includes user.errors.full_messages, "Password digest can't be blank"
  end

  test "email must be unique" do
    email = 'user@example'
    FactoryGirl.create(:user, email: email)
    second = FactoryGirl.build(:user, email: email)
    refute second.validate
    assert_includes second.errors.full_messages, 'Email has already been taken'
  end

  test "user gets a uuid upon create" do
    user = FactoryGirl.create(:user)
    assert user.uuid
  end
end
