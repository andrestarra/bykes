class Station < ApplicationRecord
  has_many :rentals, dependent: :destroy
end
