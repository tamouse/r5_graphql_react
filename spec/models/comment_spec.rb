require "rails_helper"

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @user.posts.create(FactoryGirl.attributes_for(:post))
  end

  after do
    @user.destroy
  end

  it "must have body, post, and an author" do
    expect(subject).not_to be_valid
    expect(subject.errors.full_messages).to include("Body can't be blank")
    expect(subject.errors.full_messages).to include("Post can't be blank")
    expect(subject.errors.full_messages).to include("Author can't be blank")
  end

  it "must have unique uuid" do
    comment = @user.posts.first.comments.create(FactoryGirl.attributes_for(:comment))
    comment2 = @user.posts.first.comments.build(FactoryGirl.attributes_for(:comment, uuid: comment.uuid))
    expect(comment2).not_to be_valid
    expect(comment2.errors.full_messages).not_to include("Uuid has already been taken")
  end
end
