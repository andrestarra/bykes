# frozen_string_literal: true

# Admin Model
class Admin < ApplicationRecord
  devise :database_authenticatable, :trackable, :timeoutable, :lockable
end
