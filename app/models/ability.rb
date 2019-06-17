# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin_station
      can :read, Record
      can :create, Record
      can :read, Station
      can :finalize, Record
    else
      can :read, Rental
      can :create, Rental
      can :read, Station
    end
  end
end
