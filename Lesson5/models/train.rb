require_relative '../modules/vendor.rb'
require_relative '../modules/instance_count.rb'

class Train
  include Vendor
  include InstanceCounter

  attr_accessor :routes, :choosen_route, :current_station
  attr_reader  :number, :carriages, :speed

  @@trains = {}

  def initialize(number)
    @number = number
    @carriages = []
    @routes = []
    @speed = 0
    @choosen_route = nil
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def next_station
    #puts "Previous_station station is #{@routes[choosen_route_index].stations[@current_station_index + 1].name}."
    index = @current_station_index
    #self.routes[choosen_route_index].stations[@current_station_index + 1]
    self.routes[choosen_route_index].stations[index + 1]
  end

  def previous_station
    #puts "Previous_station station is #{@routes[choosen_route_index].stations[@current_station_index - 1].name}."
    index = @current_station_index
    self.routes[choosen_route_index].stations[index - 1]
    #self.routes[choosen_route_index].stations[@current_station_index - 1]
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

  def hook_carriage(carriage)
    if speed == 0 && self.type == carriage.type
      self.carriages << carriage
    else
      puts "Train must be stoped first or you trying to add a wrong type of carriage!"
    end
  end

  def unhook_carriage(carriage)
    if speed == 0
      self.carriages.delete(carriage)
    else
      puts "Train must be stoped first."
    end
  end

  protected

  attr_writer :speed
  attr_accessor :current_station_index, :choosen_route_index

end