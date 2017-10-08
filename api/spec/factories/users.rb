require "faker"
FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "password"

    factory :author

    factory :admin do
      admin true
    end
  end
end
