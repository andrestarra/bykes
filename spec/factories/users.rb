require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    identification { Faker::Number.unique.number(10) }
    address { Faker::Address.street_address }
    email { Faker::Internet.unique.email }
    password { Faker::Alphanumeric.alphanumeric(8) }

    factory :admin_station do
      after(:create) { |user| user.add_role(:admin_station) }
    end
  end
end
