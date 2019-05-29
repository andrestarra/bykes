class StationsController < ApplicationController
  def new
    @station = Station.new
  end

  def create
    @station = Station.new

    if @station.save
      redirect_to @station
    else
      render 'new'
    end
  end
end
