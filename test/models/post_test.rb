require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @author = FactoryGirl.create(:user)
  end

  test "post requires an user, a title, and a body" do
    post = Post.new
    refute post.validate
    assert_includes post.errors.full_messages, "Title can't be blank"
    assert_includes post.errors.full_messages, "Body can't be blank"
    assert_includes post.errors.full_messages, "User can't be blank"
  end




end
