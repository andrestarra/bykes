class Bike < ApplicationRecord
  include AASM

  has_many :records
  belongs_to :station, counter_cache: :available_bikes

  # after_commit :update_stations

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

  # protected

  # def update_stations
  #   Station.all.each do |station|
  #     quantity = station.bikes.count
  #     station.update(available_bikes: quantity)
  #   end
  # end
end
