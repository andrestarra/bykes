require 'faker'

FactoryBot.define do
  factory :rental do
    code { Faker::Alphanumeric.unique.alphanumeric(6) }
    hours { rand(24) }
    station
    user
  end
end
