require 'rails_helper'

RSpec.describe Bike, type: :model do
  describe 'associations' do
    subject { build(:bike) }

    it { should have_many(:records).class_name('Record') }
    it { should belong_to(:station).class_name('Station') }
  end

  describe 'validations' do
    subject { build(:bike) }

    it { should validate_presence_of(:serial_number) }
    it { should validate_uniqueness_of(:serial_number) }
    it { should validate_length_of(:serial_number).is_equal_to(6) }
    it { should validate_presence_of(:state) }
  end
end
