class Record < ApplicationRecord
  belongs_to :rental
  belongs_to :bike
  belongs_to :station
end
