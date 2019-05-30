class RentalsController < ApplicationController
  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.user_id = current_user.id

    if @rental.save
      redirect_to @rental
    else
      render 'new'
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:plan, :code, :station_id)
  end
end
