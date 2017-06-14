    # Имеет начальную и конечную станцию, а также список промежуточных станций.
    #Начальная и конечная станции указываютсся при создании маршрута,
    #а промежуточные могут добавляться между ними.
    # Может добавлять промежуточную станцию в список
    # Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station_name)
    @stations.insert(-2,station_name)
  end

  def delete_station(station_to_delete)
    @stations.delete_if{|intermediate_station| intermediate_station == station_to_delete}
    puts "Station #{station_to_delete} was deleted."
  end

  def all_stations
    puts @stations
  end
end
