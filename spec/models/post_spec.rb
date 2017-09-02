require "rails_helper"

RSpec.describe Post, type: :model do
  it "must have a user, a title, and a body" do
    expect(subject).not_to be_valid
    expect(subject.errors.full_messages).to include("User can't be blank")
    expect(subject.errors.full_messages).to include("Title can't be blank")
    expect(subject.errors.full_messages).to include("Body can't be blank")
  end

  describe "scopes" do
    before do
      @user = FactoryGirl.create(:user)
      @user.posts.create(FactoryGirl.attributes_for_list(:post, 5))
      @user.posts.create(FactoryGirl.attributes_for_list(:published_post, 10))
    end

    after do
      @user.destroy
    end

    it "has 15 posts" do
      expect(@user.posts.count).to eq(15)
    end

    it "has 10 published posts" do
      expect(@user.posts.published.count).to eq(10)
    end

    it "has 5 drafts" do
      expect(@user.posts.drafts.count).to eq(5)
    end

  end
end
