require "./station.rb"
require "./route.rb"

class Train

  attr_accessor :speed
  attr_reader :number_of_carts, :type, :number, :route

  def initialize (number, type, number_of_carts)
    @number = number
    @type = type
    @number_of_carts = number_of_carts
    @speed = 0
    @current_station_number = nil
  end

  def start_moving
    self.speed = 20
  end

  def stop
    self.speed = 0
  end

  def add_cart(carts_added)
    if @speed == 0
      @number_of_carts += carts_added
    else
      puts "A cart can be added only when the train is stopped!"
    end
  end

  def delete_cart(carts_deleted)
    if @speed == 0
      @number_of_carts -= carts_deleted
    else
      puts "A cart can be deleted only when the train is stopped!"
    end
  end

  def add_route(route)
    @route = route
    @current_station = route.stations.first.station_name
    puts "Current station is #{@current_station}."
    @route.stations.each_with_index do |station, index|
      if station.station_name == @current_station
        @current_station_number = index
        puts "Number of the current station is #{@current_station_number}."
      end
    end
  end

  def move_train(direction)
    if direction == "forward"
      @current_station = @route.stations[@current_station_number + 1].station_name
    elsif direction == "back"
      @current_station = @route.stations[@current_station_number - 1].station_name
    else
      puts "Please enter valid commend"
    end
  end

  def previous_station
    @previous_station = @route.stations[@current_station_number - 1].station_name
  end

  def next_station
    @next_station = @route.stations[@current_station_number + 1].station_name
  end

  def current_station
    @current_station
  end

end
