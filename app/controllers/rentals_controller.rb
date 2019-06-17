class RentalsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @rentals = Rental.my_rentals(current_user)
  end

  def show
    @station = Station.find(params[:station_id])
    @rental = @station.rentals.find(params[:id])
  end

  def new
    @station = Station.find(params[:station_id])
  end

  def create
    @station = Station.find(params[:station_id])
    @rental = @station.rentals.build(rental_params)
    @rental.user_id = current_user.id

    if @rental.save
      redirect_to station_rental_path(@station, @rental), success: 'Rental was successfully!'
    else
      render 'show'
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:hours)
  end
end
