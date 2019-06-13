class Station < ApplicationRecord
  has_many :rentals, dependent: :destroy
  has_many :records
  has_many :bikes

  # before_update :update_bikes

  validates :address, :available_bikes, presence: true

  # protected

  # def update_bikes
  #   quantity = self.bikes.count
  #   self.available_bikes = quantity
  # end
end
