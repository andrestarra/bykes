class Bike < ApplicationRecord
  has_many :records
  belongs_to :station
end
