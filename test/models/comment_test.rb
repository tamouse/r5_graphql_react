require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "comment must have body, post, and user" do
    comment = Comment.new
    refute comment.validate
    assert_includes comment.errors.full_messages, "Body can't be blank"
    assert_includes comment.errors.full_messages, "Post can't be blank"
    assert_includes comment.errors.full_messages, "User can't be blank"
  end

  test "user can create comments on another user's post" do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)

    assert @user1.posts.create(FactoryGirl.attributes_for(:post))
    assert @user2.comments.create(FactoryGirl.attributes_for(:comment, post: @user1.posts.first))
  end

  test "when user is deleted, all posts and comments are deleted as well" do
    assert_empty User.all
    assert_empty Post.all
    assert_empty Comment.all

    @user1 = FactoryGirl.create(:user)
    @user1.posts.create(FactoryGirl.attributes_for_list(:post, 3))
    @user1.posts.each do |post|
      post.comments.create(FactoryGirl.attributes_for_list(:comment, 2))
    end

    @user1.destroy

    assert_empty User.all
    assert_empty Post.all
    assert_empty Comment.all

  end
end
