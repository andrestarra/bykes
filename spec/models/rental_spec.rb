require 'rails_helper'

RSpec.describe Rental, type: :model do
  describe 'associations' do
    subject { build(:rental) }

    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:station).class_name('Station') }
    it { should have_one(:record).class_name('Record') }
  end

  describe 'validations' do
    subject { build(:rental) }

    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:hours) }
    it do
      should validate_numericality_of(:hours).
        is_greater_than(0).is_less_than(25)
    end
  end
end
