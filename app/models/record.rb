class Record < ApplicationRecord
  include AASM

  belongs_to :rental
  belongs_to :bike
  belongs_to :station

  before_validation :assign_rental, :assign_station, :assign_bike, :assign_hours, on: :create
  after_update :release_bike
  after_touch :verify_state

  validates :rental_code, presence: true, uniqueness: true
  validates :state, presence: true

  aasm column: :state do
    state :actual, initial: true
    state :finished, :delayed

    event :finalize do
      transitions from: [:actual, :delayed], to: :finished
    end
    
    event :delay do
      transitions from: :actual, to: :delay
    end
  end

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
    Bike.bikes_by_station(self.station_id).available.first
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

  def release_bike
    if self.bike.may_dispose? && self.state == 'finished' 
      self.bike.dispose!
    end
  end

  def verify_state
    if self.ends_at.past? && self.state != 'finished'
      self.delay!
    end
  end
end
