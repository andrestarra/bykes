class RentalsController < ApplicationController
  def create
    @station = Station.find(params[:station_id])
    @rental = @station.rentals.build(rental_params)
    @rental.user_id = current_user.id

    if @rental.save
      redirect_to @rental, success: 'Rental was successfully!'
    else
      render 'new'
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:plan)
  end
end
