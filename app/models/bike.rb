class Bike < ApplicationRecord
  include AASM

  has_many :records
  belongs_to :station

  after_save :update_counter_cache
  after_destroy :update_counter_cache

  validates :serial_number, presence: true, uniqueness: true, length: { is: 6 }
  validates :state, presence: true

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

  def update_counter_cache
    available_bikes = Bike.where(state: 'available', station_id: self.station.id).count
    self.station.update_attributes(available_bikes: available_bikes)
  end
end
