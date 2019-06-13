class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :station
  has_one :record, dependent: :destroy
  
  before_save :unique_code

  validates :code, uniqueness: true
  validates :hours, presence: true

  scope :my_rentals, ->(current_user) { where(user_id: current_user.id) }

  protected

  def generate_code(number)
    charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
    Array.new(number) { charset.sample }.join
  end

  def unique_code
    self.code = loop do
      random_code = generate_code(6)
      break random_code unless Rental.exists?(code: random_code)
    end
  end
end
