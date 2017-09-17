require "faker"

FactoryGirl.define do
  factory :post do
    title {Faker::Lorem.sentence}
    body {Faker::Lorem.paragraph}

    factory :published_post do
      published_at {Time.current}
    end

    factory :post_with_author do
      author

      factory :published_post_with_author do
        published_at {Time.current}
      end

    end
  end
end
