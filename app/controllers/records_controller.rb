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
    @record = Record.new(record_params)

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
    require.params(:record).permit(:ends_at, :rental_id, :bike_id, :station_id)
  end

  def find_record
    @record = Record.find(params[:id])
  end
end
