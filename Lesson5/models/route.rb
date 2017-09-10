class Route
  attr_reader :stations

  def initialize (first, last)
    @stations = [first, last]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def all_stations
    @stations.each { |station| puts "Station: #{station.name}." }
  end

end
