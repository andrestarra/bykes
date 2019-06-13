class Record < ApplicationRecord
  belongs_to :rental
  belongs_to :bike
  belongs_to :station

  before_validation :assign_rental, :assign_station, :assign_bike
  before_save :assign_hours

  validates :rental_code, presence: true, uniqueness: true

  protected

  def rental_code_exist
    Rental.exists?(code: self.rental_code)
  end

  def rental_of_the_code
    Rental.find_by(code: self.rental_code)
  end

  def assign_rental
    if rental_code_exist
      self.rental_id = rental_of_the_code.id
    else
      errors.add(:rental_code, 'does not exist. Try another!')
    end
  end

  def assign_station
    if rental_code_exist
      self.station_id = rental_of_the_code.station_id
    end
  end

  def bike_station
    Bike.bikes_by_station(self.station_id).first
  end

  def assign_bike
    if rental_code_exist
      self.bike_id = bike_station.id
      self.bike.rent!
    end
  end

  def assign_hours
    hrs = self.rental.hours
    self.ends_at = DateTime.now + hrs.hours
  end
end
