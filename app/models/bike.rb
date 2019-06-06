class Bike < ApplicationRecord
  include AASM

  has_many :records
  belongs_to :station

  validates :serial_number, presence: true
  validates :state, presence: true

  aasm do
    state :working, initial: true
    state :maintenance

    event :in_maintenance do
      transitions from: :working, to: :maintenance
    end

    event :put_to_work do
      transitions from: :maintenance, to: :working
    end
  end
end
