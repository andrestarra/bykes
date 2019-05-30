# frozen_string_literal: true

# Bike model
class Bike < ApplicationRecord
  belongs_to :station
end
