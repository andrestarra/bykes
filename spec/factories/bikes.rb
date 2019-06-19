require 'faker'

FactoryBot.define do
  factory :bike do
    serial_number { Faker::Alphanumeric.unique.alphanumeric(6) }
    state { 'available' }
    station
  end
end
