class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  #Add a train to the list of trains
  def add_train(train)
    self.trains << train
    puts "The train number #{train.number} has come to the station #{self.name}"
  end

  # Print the list of trains
  def list
    self.trains.each do |train|
      puts "Train number #{train.number}, type of #{train.type}, with #{train.number_of_carts} carts."
    end
  end

  # Print total number of train types
  def by_type(type)
    self.trains.select.count { |train| train.type if train.type == type}
  end

  #Delete a train from the array trains
  def train_departure(departured_train)
    puts "Enter the number of the train for the next departure: "
    @trains.delete_if {|train| train.number == departured_train}
    puts "The train number #{departured_train} has departured from the #{self.name} station."
  end

end
