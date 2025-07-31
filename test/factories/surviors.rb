FactoryBot.define do
  factory :survivor, class: Survivor do
    name { Faker::Name.name }
    age { rand(18..60) }
    gender { Survivor.genders.keys.sample }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    trait :with_inventory do
      after(:create) do |survivor|
        create(:inventory, survivor: survivor)
      end
    end
  end
end
