require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    subject { build(:user) }

    it { should have_many(:rentals).class_name('Rental') }
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:first_name) }
    it do
      should validate_length_of(:first_name).
        is_at_least(3).is_at_most(15)
    end
    it { should validate_presence_of(:last_name) }
    it do
      should validate_length_of(:last_name).
        is_at_least(3).is_at_most(15)
    end
    it { should validate_presence_of(:identification) }
    it { should validate_uniqueness_of(:identification).case_insensitive }
    it { should validate_numericality_of(:identification) }
    it do
      should validate_length_of(:identification).
        is_at_least(8).is_at_most(12)
    end
    it { should validate_presence_of(:address) }
    it do
      should validate_length_of(:address).
        is_at_least(10).is_at_most(30)
    end
  end
end
