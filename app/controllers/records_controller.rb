class RecordsController < ApplicationController
  before_action :find_record, except: [:index, :new, :create]
  def index
    @records = Record.all
  end

  def show
  end

  def new
    @record = Record.new
  end

  def edit
  end

  def create
    rental = Rental.find_by!(code: record_params[:rental_code])
    @record = Record.new(record_params)
    @record.rental_id = rental.id
    hrs = (rental.plan).to_i
    @record.ends_at = DateTime.now + hrs.hours
    @record.station_id = rental.station_id

    if @record.save
      redirect_to @record
    else
      render 'new'
    end
  end

  def update
    if @record.update(record_params)
      redirect_to @record
    else
      render 'edit'
    end
  end

  def destroy
    @record.destroy
    redirect_to records_path
  end

  private

  def record_params
    params.require(:record).permit(:rental_code, :bike_id)
  end

  def find_record
    @record = Record.find(params[:id])
  end
end
