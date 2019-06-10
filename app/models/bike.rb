class Bike < ApplicationRecord
  has_many :records
  belongs_to :station
  after_save :update_station_owner

  validates :serial_number, presence: true
  validates :state, presence: true

  protected

  def update_station_owner
    station = Station.find_by(id: station_id)
    quantity = Bike.where(station_id: station_id).count
    station.available_bikes = quantity
    station.save
  end
end
