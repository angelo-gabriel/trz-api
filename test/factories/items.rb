FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item #{n} #{Faker::Commerce.product_name}" }
    price { [10, 20, 30, 40].sample }
    quantity { rand(1..10) }
    association :inventory
  end

  trait :fiji_water do
    name { "Fiji Water" }
    price { 14 }
  end

  trait :campbell_soup do
    name { "Campbel Soup" }
    price { 12 }
  end

  trait :first_aid_pouch do
    name { "First Aid Pouch" }
    price { 10 }
  end

  trait :ak47 do
    name { "AK47" }
    price { 8 }
  end
end
