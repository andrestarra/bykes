class Bike < ApplicationRecord
  has_many :records
  belongs_to :station

  after_commit :update_stations

  validates :serial_number, presence: true
  validates :state, presence: true

  scope :bikes_by_station, ->(station) { where(station_id: station) }

  protected

  def update_stations
    Station.all.each do |station|
      quantity = station.bikes.count
      station.update(available_bikes: quantity)
    end
  end
end
