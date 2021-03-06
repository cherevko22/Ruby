#####################################################---Station---########################################################################
class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  #Add a train to the list of trains
  def add_train(train)
    @trains << train
    #puts "The train number #{train.number} has come to the station #{self.name}"
  end

  # Print the list of trains
  def list
    self.trains.each do |train|
      puts "Train number #{train.number}, type of #{train.type}, with #{train.number_of_carts} carts."
    end
  end

  # Print total number of train types
  def by_type(type)
    @trains.select.count { |train| train.type if train.type == type}
  end

  #Delete a train from the array trains
  def train_departure(departured_train)
    puts "Enter the number of the train for the next departure: "
    @trains.delete_if {|train| train.number == departured_train}
    puts "The train number #{departured_train} has departured from the #{self.name} station."
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
    #@stations.delete_if{|intermediate_station| intermediate_station == station_to_delete}
    @stations.delete(station_to_delete)
  end

end
#####################################################---Train---########################################################################

class Train

  attr_reader :number_of_carts, :type, :number, :route, :speed

  def initialize (number, type, number_of_carts)
    @number = number
    @type = type
    @number_of_carts = number_of_carts
    @speed = 0
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
    if @speed == 0 && carts_deleted < @number_of_carts
      @number_of_carts -= carts_deleted
    else
      puts "A cart can be deleted only when the train is stopped! Make sure that the train has enough carts."
    end
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

  def previous_station
    @route.stations[@current_station_number - 1]
  end

  def next_station
    @route.stations[@current_station_number + 1]
  end

  def current_station
    @current_station = @route.stations[@current_station_number]
  end

end
