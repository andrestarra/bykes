class StationsController < ApplicationController
  before_action :find_station, only: [:edit, :update]

  def new
    @station = Station.new
  end

  def edit
  end

  def create
    @station = Station.new(station_params)

    if @station.save
      redirect_to @station
    else
      render 'new'
    end
  end

  def update
    if @station.update(station_params)
      redirect_to @station
    else
      render 'edit'
    end
  end

  private

  def station_params
    params.require(:station).permit(:address, :total_positions, :available_positions)
  end

  def find_station
    @station = Station.find(params[:id])
  end
end
