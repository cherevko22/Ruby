class Route
  include Validation

  attr_reader :stations, :first, :last

  def initialize (first, last)
    @first = first
    @last = last
    validate!
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

  protected

  def validate!
    raise "Arguments should calss of Statioin!!!" unless Station.all.include?(last && last)
    raise "First station shouldn't be the same as last one!!!" if self.first == self.last
    true
  end

end
