# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  rolify
  after_create :assign_default_role

  has_many :rentals, dependent: :destroy

  validates :first_name, :last_name, presence: true, length: { in: 3..15 }
  validates :identification, presence: true, uniqueness: true, length: { in: 8..12 }
  validates :address, presence: true, length: { in: 10..30 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  protected

  def assign_default_role
    add_role(:default) if roles.blank?
  end
end
