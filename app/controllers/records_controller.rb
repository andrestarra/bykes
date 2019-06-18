# frozen_string_literal: true

# Records Controller
class RecordsController < ApplicationController
  before_action :find_record, except: %i[index new create]
  load_and_authorize_resource

  def index
    @records = Record.order(:state)
    touch_records
  end

  def show
    @record.touch if @record.actual?
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

  def touch_records
    @records.each do |record|
      record.touch if record.actual?
    end
  end
end
