require './postcode_api.rb'
require './tfl_bus_arrival_api.rb'

require 'open-uri'
require 'json'

class BusBoard
  attr_reader :bus_stop_id

  def initialize
    bus_arrival_api = TflBusArrivalAPI.new
    bus_arrival_api.request_data('490008660N')
  end


end



BusBoard.new
