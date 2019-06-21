require 'faker'

FactoryBot.define do
  factory :rental do
    code { Faker::Alphanumeric.unique.alphanumeric(6) }
    hours { rand(1..24) }
    station
    user

    trait :invalid do
      hours { nil }
    end
  end
end
