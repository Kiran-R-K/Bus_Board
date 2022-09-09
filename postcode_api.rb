require 'open-uri'
require 'json'

class PostcodeAPI
  attr_reader :postcode_longitude, :postcode_latitude

  def initialize(postcode)
    postcode_data(postcode)
  end
  def postcode_data(postcode)
    url = "https://api.postcodes.io/postcodes/#{postcode}"
    url_data = URI.open(url).read
    json_data =  JSON.parse(url_data)
    postcode_info_only = json_data["result"]
    @postcode_longitude = postcode_info_only["longitude"]
    @postcode_latitude = postcode_info_only["latitude"]
  end

end