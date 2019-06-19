require 'faker'

FactoryBot.define do
  factory :station do
    address { Faker::Address.unique.street_address }
    available_bikes { 5 }

    trait :invalid do
      address { nil }
    end

    trait :not_available do
      available_bikes { 0 }
    end
  end
end
