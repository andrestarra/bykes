FactoryBot.define do
  factory :record do
    rental
    bike
    station

    trait :invalid do
      rental_code { nil }
    end
  end
end
