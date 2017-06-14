#####################################################---Station---########################################################################
class Station

  attr_reader :station_name, :list_of_trains

  def initialize(station_name)
    @station_name = station_name
    @list_of_trains = []
  end

  #Add a train to the list of trains
  def add_train(train)
    self.list_of_trains << train
    puts "The train number #{train.number} has come to the station #{self.station_name}"
  end

  # Print the list of trains
  def list
    self.list_of_trains.each do |train|
      puts "Train number #{train.number}, type of #{train.type}, with #{train.number_of_carts} carts."
    end
  end

  # Print total number of train types
  def by_type(type)
    self.list_of_trains.select.count { |train| train.type if train.type == type}
  end

  #Delete a train from the array list_of_trains
  def train_departure(departured_train)
    puts "Enter the number of the train for the next departure: "
    @list_of_trains.delete_if {|train| train.number == departured_train}
    puts "The train number #{departured_train} has departured from the #{self.station_name} station."
  end

end
#####################################################---Route---########################################################################
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
#####################################################---Train---########################################################################

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

  def move_forward
    if @route.stations[@current_station_number + 1] != nil
      @current_station = @route.stations[@current_station_number + 1].station_name
    else
      puts "The train is at the final destination!"
    end
  end

  def move_back
    if @route.stations[@current_station_number - 1] != nil
      @current_station = @route.stations[@current_station_number - 1].station_name
    else
      puts "The train is at the starting station."
    end
  end

  def previous_station
    @route.stations[@current_station_number - 1].station_name
  end

  def next_station
    @route.stations[@current_station_number + 1].station_name
  end

  def current_station
    @current_station
  end

end
