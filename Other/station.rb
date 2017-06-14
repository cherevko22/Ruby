require "./train.rb"
require "./route.rb"

class Station

  attr_reader :station_name

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
