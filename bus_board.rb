require './postcode_api.rb'
require './tfl_bus_arrival_api.rb'
require './nearest_stops_api.rb'


class BusBoard


  def start
    puts "please input the postcode you want to search near"
    postcode = gets.chomp.delete(' ')
    postcode_info = PostcodeAPI.new(postcode)
    find_nearest_bus_stops(postcode_info.postcode_longitude,postcode_info.postcode_latitude)
  end

  def find_nearest_bus_stops(longitude, latitude)
    nearest_stops = NearestStopAPI.new(longitude,latitude)
    display_bus_arrivals(nearest_stops.stop_point_one, nearest_stops.stop_point_one_name)
    display_bus_arrivals(nearest_stops.stop_point_two, nearest_stops.stop_point_two_name)
  end

  def display_bus_arrivals(stop_id,stop_name)
    TflBusArrivalAPI.new(stop_id, stop_name)
  end




end



bus_board = BusBoard.new
bus_board.start