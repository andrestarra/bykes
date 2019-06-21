require 'rails_helper'

RSpec.describe Record, type: :model do
  let!(:station) { create(:station) }
  let!(:bike) { create(:bike, station_id: station.id) }
  let!(:rental) { create(:rental, station_id: station.id) }

  describe 'associations' do
    subject { build(:record) }

    it { should belong_to(:rental).class_name('Rental') }
    it { should belong_to(:bike).class_name('Bike') }
    it { should belong_to(:station).class_name('Station') }
  end

  describe 'validations' do
    subject { build(:record, rental_code: rental.code) }
    
    it { should validate_presence_of(:rental_code) }
    it { should validate_uniqueness_of(:rental_code) }
  end
end
