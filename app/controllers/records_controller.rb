class RecordsController < ApplicationController
  before_action :find_record, except: [:index, :new, :create]
  def index
    @records = Record.all
  end

  def show
  end

  def finalize
    @record.finalize!
    redirect_to records_path
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to @record
    else
      render 'new'
    end
  end

  def destroy
    @record.destroy
    redirect_to records_path
  end

  private

  def record_params
    params.require(:record).permit(:rental_code)
  end

  def find_record
    @record = Record.find(params[:id])
  end
end
