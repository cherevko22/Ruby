class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def incoming(train)
    @trains << train
  end

  def by_type(type)
    @trains.select.count { |train| train.type if train.type == type}
  end

  def all_trains
    @trains.each { |train| puts "Train number: #{train.number}." }
  end

  def departure(train)
    @trains.delete(train)
  end

end


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


class Train
  attr_accessor :speed, :routes, :current_station_index, :choosen_route, :choosen_route_index, :current_station, :carriages
  attr_reader :speed, :type, :number

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @routes = []
    @speed = 0
    @choosen_route = nil
  end

  def next_station
    puts "Previous_station station is #{@routes[choosen_route_index].stations[@current_station_index + 1].name}."
  end

  def previous_station
    puts "Previous_station station is #{@routes[choosen_route_index].stations[@current_station_index - 1].name}."
  end

  def move_back
    self.current_station_index -= 1
    self.current_station = routes[@choosen_route_index].stations[current_station_index]
  end

  def move_forward
    self.current_station_index += 1
    self.current_station = routes[@choosen_route_index].stations[current_station_index]
  end

  def set_route(route)
    @routes << route
    self.choosen_route = route
    self.choosen_route_index = routes.index(@choosen_route)
    self.current_station = route.stations.first
    self.current_station_index = route.stations.index(@current_station)
  end

  def start
    self.speed = 10
  end

  def stop
    self.speed = 0
  end

  def hook_carriage
    if speed == 0
      @carriages += 1
    else
      puts "Train must be stoped first."
    end
  end

  def unhook_carriage
    if speed == 0
      @carriages -= 1
    else
      puts "Train must be stoped first."
    end
  end

end
