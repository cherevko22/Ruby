class Route
  include Validation

  attr_reader :stations, :first, :last

  def initialize (first, last)
    @first = first
    @last = last
    @stations = [first, last]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def delete_station(station)
    self.stations.delete(station)
  end

  def all_stations
    self.stations.each { |station| puts "Station: #{station.name}." }
  end

end
