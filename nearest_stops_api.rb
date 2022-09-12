require 'open-uri'
require 'json'

class NearestStopAPI
  attr_reader :stop_point_one, :stop_point_two

  def initialize(longitude, latitude)
    find_near_stops(longitude, latitude)
  end

  def find_near_stops(longitude, latitude)
    stop_types = "NaptanBusCoachStation,NaptanBusWayPoint,NaptanOnstreetBusCoachStopCluster,NaptanOnstreetBusCoachStopPair,NaptanPrivateBusCoachTram,NaptanPublicBusCoachTram"
    url = "https://api.tfl.gov.uk/StopPoint/?lat=#{latitude}&lon=#{longitude}&stopTypes=#{stop_types}"
    url_data = URI.open(url).read
    json_data =  JSON.parse(url_data)
    sort_stops_by_nearest(json_data)
  end

  def sort_stops_by_nearest(data)
    data["stopPoints"].sort_by { |stop| stop["distance"] }
    @stop_point_one =  data['stopPoints'][0]['children'][1]['naptanId']
    @stop_point_two =  data['stopPoints'][1]['children'][1]['naptanId']
  end

end