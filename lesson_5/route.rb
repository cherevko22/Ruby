class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station_name)
    @stations.insert(-2,station_name)
  end

  def delete_station(station_to_delete)
    @stations.delete(station_to_delete)
  end

end
