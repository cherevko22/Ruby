require_relative 'modules/manufacturer.rb'

class Train

  include Manufacturer

  attr_reader :number, :route, :speed, :type, :carriages, :current_station
  attr_accessor :speed

  @@trains = []

  def initialize (number)
    @number = number
    @speed = 0
    @carriages = []
    @amount_carriages = @carriages.count
    @@trains[number] = self
  end

  def self.find(number)
    @@trains[number]
  end

  def add_carriage(carriage)
    if @speed == 0
      if self.type == carriage.type
        @carriages << carriage
      else
        puts "Wront type of the carriage."
      end
    else
      puts "Train must be stopped first."
    end
  end

  def previous_station
    @current_station = @route.stations[@current_station_number - 1]
  end

  def next_station
    @current_station = @route.stations[@current_station_number + 1]
  end

  def start_moving
    self.speed = 20
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station_number = @route.stations.index(@current_station)
  end

  def move_forward
    @current_station_number += 1
  end

  def move_back
    @current_station_number -= 1
  end

  def current_station
    @current_station = @route.stations[@current_station_number]
  end

  def stop
    self.speed = 0
  end

  def delete_carriage(remove)
    if @speed == 0
      @carriages.delete(remove)
    else
      puts "A carriage can be deleted only when the train is stopped!"
    end
  end

end
