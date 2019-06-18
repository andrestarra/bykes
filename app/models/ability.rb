# frozen_string_literal: true

# Ability
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin_station
      can :manage, Record
    else
      can :read, Rental
      can :create, Rental
    end
  end
end
