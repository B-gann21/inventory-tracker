FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password(min_length: 60) }
  end
end
