require './postcode_api.rb'
require './tfl_bus_arrival_api.rb'


class BusBoard
  attr_reader :bus_arrival_api, :postcode_api

  def initialize
    @bus_arrival_api = TflBusArrivalAPI.new
    # for testing: bus_arrival_api.request_data('490008660N')
  end

  def start
    puts "please input the postcode you want to search near"
    postcode = gets.chomp.delete(' ')
    postcode_info = PostcodeAPI.new(postcode)
    puts postcode_info.postcode_longitude
    puts postcode_info.postcode_latitude
  end




end



bus_board = BusBoard.new
bus_board.start