class StationsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
  end
end
