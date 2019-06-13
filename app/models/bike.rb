class Bike < ApplicationRecord
  include AASM

  has_many :records
  belongs_to :station, counter_cache: :available_bikes

  validates :serial_number, presence: true

  scope :bikes_by_station, ->(station) { where(station_id: station) }

  aasm column: :state do
    state :available, initial: true
    state :rented

    event :rent do
      transitions from: :available, to: :rented
    end

    event :dispose do
      transitions from: :rented, to: :available
    end
  end
end
