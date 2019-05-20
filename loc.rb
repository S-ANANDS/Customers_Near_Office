require 'json'
require 'pry'

class Location
    attr_reader :latitude, :longitude
    EARTH_RADIUS_KM = 6371
  
    def initialize(latitude:, longitude:)
      @latitude = latitude
      @longitude = longitude
    end
  
    def to_radian(degrees)
      (Math::PI / 180) * degrees
    end
  
    def distance_to(location)
      a = Math.sin(to_radian(latitude - location.latitude) / 2)
      b = Math.sin(to_radian(longitude - location.longitude) / 2)
      c = a**2 + b**2 * Math.cos(to_radian(latitude)) * Math.cos(to_radian(location.latitude))
      2 * Math.atan2(Math.sqrt(c), Math.sqrt(1 - c)) * EARTH_RADIUS_KM
    end  
  
end  

def file_reader(file_input)
    file = File.open(file_input)
    lines=file.readlines
    
end
def parser(lines)
  lines.map do |x|
    JSON.parse(x)
  end
end

def filter(processed_data)
  value= processed_data.select do |customer|
    office = Location.new(latitude: 53.3381985, longitude: -6.2592576)
    l=Location.new(latitude:customer['latitude'].to_f,longitude: customer['longitude'].to_f )
    office.distance_to(l)>=100  
  end

end

def sorter(filtered_data)
  filtered_data.sort_by!{|x| x["user_id"]}
  filtered_data.each do |x|
    puts "#{x["user_id"]},#{x["name"]}" 
  end
end
# binding.pry
# print data.select { |x| x["name"] == 'Charlie Halligan'  }
data=file_reader("customers.json")
processed_data=parser(data)
filtered_data=filter(processed_data)
sorter(filtered_data)
# print value.sort()
#  binding.pry


  
  
  