class Station < ApplicationRecord
  has_many :rentals
  has_many :records
  has_many :bikes
end
