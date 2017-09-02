require "faker"
FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    admin false
    password "password"
    password_confirmation "password"
  end
end
