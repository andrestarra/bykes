class Record < ApplicationRecord
  belongs_to :rental
  belongs_to :bike
  belongs_to :station

  validates :rental_code, presence: true, uniqueness: true
  validate :rental_code_existence

  protected

  def rental_code_existence
    if Rental.exists?(code: self.rental_code)
      rental = Rental.find_by(code: self.rental_code)
      self.rental_id = rental.id
      hrs = (rental.plan).to_i
      self.ends_at = DateTime.now + hrs.hours
      self.station_id = rental.station_id
    else
      errors.add(:rental_code, "does not exist. Try another!")
    end
  end
end
