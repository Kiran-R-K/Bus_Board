require 'open-uri'
require 'json'

class BusBoard
  attr_reader :bus_stop_id

  def start
    puts 'Intput the bus stop code you want to check'
    @bus_stop_id = gets.chomp
    request_api_data
  end

  def request_api_data
    url = "https://api.tfl.gov.uk/StopPoint/#{@bus_stop_id}/Arrivals"
    url_data = URI.open(url).read
    json_data =  JSON.parse(url_data)
    find_soonest_busses(json_data)
  end

  def find_soonest_busses(data)
    sorted_busses = data.sort_by { |bus| bus["timeToStation"] }
    five_soonest_busses = sorted_busses[0..4]
    bus_arrivals(five_soonest_busses)
  end

  def bus_arrivals(busses_arriving)
    for bus in busses_arriving do
      arrival_time = bus["timeToStation"]/60
      puts "Bus: #{bus["lineId"]} | Destination: #{bus["destinationName"]} | Arriving in: #{arrival_time}mins"
    end
  end


end



bus_board = BusBoard.new

bus_board.start