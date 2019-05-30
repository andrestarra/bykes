class BikesController < ApplicationController
  before_action :find_bike, only: [:edit, :update]

  def new
    @bike = Bike.new
  end

  def edit
  end

  def create
    @bike = Bike.new(bike_params)

    if @bike.save
      redirect_to @bike
    else
      render 'new'
    end
  end

  def update
    if @bike.update(bike_params)
      redirect_to @bike
    else
      render 'edit'
    end
  end

  private

  def bike_params
    params.permit(:bike).permit(:serial_number, :state, :station_id)
  end

  def find_bike
    @bike = Bike.find(params[:id])
  end
end
