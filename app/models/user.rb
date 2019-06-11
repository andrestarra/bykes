class User < ApplicationRecord
  rolify
  after_create :assign_default_role

  has_many :rentals, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  protected

  def assign_default_role
    self.add_role(:default) if self.roles.blank?
  end
end
