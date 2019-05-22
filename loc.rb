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

class Customer
  attr_reader :location, :user_id, :name
  def initialize(latitude, user_id,name,longitude)
    @location = Location.new(latitude: latitude, longitude: longitude)
    @name = name
    @id = user_id
  end  
end
binding.pry
# def files(f_name)
#   file=File.open(f_name)
#   file.readlines
# end

# def parser(lines)
#   lines.map do |x| 
#     JSON.parse(x)
#   end
# end
# def filter_data(process_data)
#   process_data.select do |customer|
#     office=Location.new(latitude: 53.3381985, longitude: -6.2592576)
#     l=Location.new(latitude: customer['latitude'].to_f, longitude: customer['longitude'].to_f)
#     office.distance_to(l) >= 100
#   end
# end
# def sorts(value)
#   value.sort_by! { |x| x["user_id"] }
# end


# lines=files('customers.json')
# process_data = parser(lines)
# value=filter_data(process_data)
# values = sorts(value)
# # binding.pry
# # values.each do |x|
# #   puts " #{x["user_id"]} , #{x["name"]} "
# # end
#  process_data.each do |x|
#    person = Customer.new(x['latitude'], x['user_id'], x['name'],x['longitude'])
#   #  binding.pry
#    puts person.name
#  end