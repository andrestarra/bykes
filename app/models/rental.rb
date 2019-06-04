class Rental < ApplicationRecord
  belongs_to :user
  has_one :record
  before_save :unique_code

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
