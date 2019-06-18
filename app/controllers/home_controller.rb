# frozen_string_literal: true

# Home Controller
class HomeController < ApplicationController
  def index
    @stations = Station.all
  end
end
