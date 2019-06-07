class Bike < ApplicationRecord
  has_many :records
  belongs_to :station

  validates :serial_number, presence: true
  validates :state, presence: true
end
