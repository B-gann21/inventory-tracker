FactoryBot.define do
  factory :item do
    name { Faker::Tea.variety }
    quantity { Faker::Number.within(range: 1..20) }
    price { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    favorite { [true, false].sample }
    category { ['food/drink', 'tools/hardware', 'household/kitchen', 'other'].sample  }
  end
end
