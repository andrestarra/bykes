class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :rememberable, :validatable, :recoverable, :registerable and :omniauthable
  devise :database_authenticatable, :trackable, :timeoutable, :lockable
end
