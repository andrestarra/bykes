# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  rolify

  has_many :rentals, dependent: :destroy

  after_create :assign_default_role

  validates :first_name, :last_name, presence: true, length: { in: 3..15 }
  validates :identification, presence: true, uniqueness: { case_sensitive: false },
                             numericality: true, length: { in: 8..12 }
  validates :address, presence: true, length: { in: 10..30 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  protected

  def assign_default_role
    add_role(:default) if roles.blank?
  end
end
