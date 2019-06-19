require 'rails_helper'

RSpec.describe Station, type: :model do
  describe 'associations' do
    subject { build(:station) }

    it { should have_many(:rentals).class_name('Rental') }
    it { should have_many(:records).class_name('Record') }
    it { should have_many(:bikes).class_name('Bike') }
  end

  describe 'validations' do
    subject { build(:station) }

    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:address) }
    it do
      should validate_length_of(:address).
        is_at_least(10).is_at_most(30)
    end
    it { should validate_presence_of(:available_bikes) }
  end
end
