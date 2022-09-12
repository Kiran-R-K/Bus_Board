require 'open-uri'
require 'json'

class NearestStopAPI
  attr_reader :stop_point_ids

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
    sorted_stop_points = data["stopPoints"].sort_by { |stop| stop["distance"] }
    nearest_stops = sorted_stop_points[0..1]
    stop_point_id(nearest_stops)
  end

  def stop_point_id(stops)
    @stop_point_ids = []
    for stop in stops do
      @stop_point_ids << stop["naptanId"]
    end
  end

end