class Train
  include Vendor
  include Validator
  include InstanceCounter

  TRAIN_NUMBER = /^(\d{3}|[a-z]{3})-?(\d{2}|[a-z]{2})$/

  attr_accessor :routes, :choosen_route, :current_station
  attr_reader  :number, :carriages, :speed

  @@trains = {}

  def initialize(number)
    @number = number
    validate!
    @carriages = []
    @routes = []
    @speed = 0
    @choosen_route = nil
    @@trains[number] = self
    register_instance
  end

  def each_carriage(&block)
    self.carriages.each { |carriage| block.call(carriage) }
  end

  def all_carriages
    self.carriages.each.with_index(1) do |carriage, index|
      if carriage.type == :cargo
        puts "Index: #{index}, Capacity: #{carriage.total_capacity}"
      else
        puts "Index #{index}, Seats: #{carriage.total_seats}"
      end
    end
  end

  def self.find(number)
    @@trains[number]
  end

  def next_station
    index = @current_station_index
    self.routes[choosen_route_index].stations[index + 1]
  end

  def previous_station
    index = @current_station_index
    self.routes[choosen_route_index].stations[index - 1]
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
    if speed.zero? && self.type == carriage.type
      self.carriages << carriage
    else
      puts "Train must be stoped first or you trying to add a wrong type of carriage!"
    end
  end

  def unhook_carriage(carriage)
    if speed.zero?
      self.carriages.delete(carriage)
    else
      puts "Train must be stoped first."
    end
  end

  protected

  def validate!
    raise "Check the number!" if number !~ TRAIN_NUMBER
    true
  end

  attr_writer :speed
  attr_accessor :current_station_index, :choosen_route_index

end
