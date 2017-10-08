require "rails_helper"

RSpec.describe User, type: :model do

  it "must have name, email, and password" do
    expect(subject).not_to be_valid
    expect(subject.errors.full_messages).to include("Name can't be blank")
    expect(subject.errors.full_messages).to include("Email can't be blank")
    expect(subject.errors.full_messages).to include("Password can't be blank")
    expect(subject.errors.full_messages).to include("Password digest can't be blank")
  end

  it "uuid and email must be uniq" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user, email: user1.email, uuid: user1.uuid)
    expect(user2).not_to be_valid
    expect(user2.errors.full_messages).to include("Email has already been taken")
    expect(user2.errors.full_messages).to include("Uuid has already been taken")
  end

end
