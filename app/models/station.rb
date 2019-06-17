class Station < ApplicationRecord
  resourcify
  
  has_many :rentals, dependent: :destroy
  has_many :records
  has_many :bikes

  validates :address, presence: true, uniqueness: true
  validates :available_bikes, presence: true
end
