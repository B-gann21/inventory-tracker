FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { Faker::String.random(length: 64) }
  end
end
