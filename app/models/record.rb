# frozen_string_literal: true

# Record model
class Record < ApplicationRecord
  resourcify
  include AASM

  belongs_to :rental
  belongs_to :bike
  belongs_to :station

  before_validation :assign_rental, :assign_station, :assign_bike,
                    :assign_hours, on: :create
  after_update :release_bike
  after_touch :verify_state

  validates :rental_code, presence: true, uniqueness: true

  aasm column: :state do
    state :actual, initial: true
    state :finished, :delayed

    event :finalize do
      transitions from: %i[actual delayed], to: :finished
    end

    event :delay do
      transitions from: :actual, to: :delayed
    end
  end

  protected

  def rental_code_exist?
    Rental.exists?(code: rental_code)
  end

  def rental_of_the_code
    Rental.find_by(code: rental_code)
  end

  def assign_rental
    if rental_code_exist?
      self.rental_id = rental_of_the_code.id
    else
      errors.add(:rental_code, 'does not exist.')
    end
  end

  def station_has_bikes?
    Bike.bikes_by_station(rental.station.id).available.any?
  end

  def assign_station
    if rental_code_exist? && station_has_bikes?
      self.station_id = rental_of_the_code.station_id
    else
      errors.add(:station, 'has not bikes.')
    end
  end

  def bike_station
    Bike.bikes_by_station(station_id).available.first
  end

  def assign_bike
    if rental_code_exist? && station_has_bikes?
      self.bike_id = bike_station.id
      bike.rent!
    end
  end

  def assign_hours
    self.ends_at = DateTime.now + rental.hours.hours if rental_code_exist?
  end

  def release_bike
    bike.dispose! if bike.may_dispose?
  end

  def verify_state
    delay! if ends_at.past? && state == 'actual'
  end
end
