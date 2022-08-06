FactoryBot.define do
  factory :item do
    categories = [
      'food/drink',
      'tools/hardware',
      'household/kitchen',
      'other'
    ]

    name { Faker::Lorem.unique.characters(number: 30) }
    quantity { Faker::Number.within(range: 1..20) }
    price { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    favorite { [true, false].sample }
    category { categories.sample }
  end
end
