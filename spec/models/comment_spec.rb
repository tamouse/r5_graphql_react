require "rails_helper"

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @user.posts.create(FactoryGirl.attributes_for(:post))
  end

  after do
    @user.destroy
  end

  it "must have body, post, and user" do
    expect(subject).not_to be_valid
    expect(subject.errors.full_messages).to include("Body can't be blank")
    expect(subject.errors.full_messages).to include("Post can't be blank")
    expect(subject.errors.full_messages).to include("User can't be blank")
  end

end
