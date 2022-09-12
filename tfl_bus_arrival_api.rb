require 'open-uri'
require 'json'

class TflBusArrivalAPI

  def initialize(stop_id)
    request_data(stop_id)
  end


  def request_data(bus_stop_id)
    url = "https://api.tfl.gov.uk/StopPoint/#{bus_stop_id}/Arrivals"
    url_data = URI.open(url).read
    json_data =  JSON.parse(url_data)
    find_soonest_busses(json_data)
  end

  def find_soonest_busses(data)
    sorted_busses = data.sort_by { |bus| bus["timeToStation"] }
    five_soonest_busses = sorted_busses[0..4]
    display_bus_arrivals(five_soonest_busses)
  end

  def display_bus_arrivals(busses_arriving)
    for bus in busses_arriving do
      arrival_time = bus["timeToStation"]/60
      puts "Bus: #{bus["lineId"]} | Destination: #{bus["destinationName"]} | Arriving in: #{arrival_time}mins"
    end
  end

end
