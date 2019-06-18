# frozen_string_literal: true

# Station Model
class Station < ApplicationRecord
  resourcify

  has_many :rentals, dependent: :destroy
  has_many :records
  has_many :bikes

  validates :address, presence: true, uniqueness: true, length: { in: 10..30 }
  validates :available_bikes, presence: true
end
