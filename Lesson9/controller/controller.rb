class Controller

  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def menu
    puts 'Select an action:'
    puts '1 - Create a station'
    puts '2 - Create a train'
    puts '3 - Create a route'
    puts '4 - Add a station to a route'
    puts '5 - Delete a station from a route'
    puts '6 - Add a route to a traine'
    puts '7 - Add a carriage to a train'
    puts '8 - Delete a carriage from a train'
    puts '9 - Move a train to the next station'
    puts '10 - Move a train to the privious station'
    puts '11 - List of all stations'
    puts '12 - List of trains on a station'
    puts '13 - List of carriages'
    puts '14 - Use carriage'
  end

  def execute(user_choice)
    case user_choice
      when 1  then create_station
      when 2  then create_train
      when 3  then route_validate_create
      when 4  then new_station_validate_add
      when 5  then route_validate_delete
      when 6  then route_validate_add
      when 7  then add_carriage
      when 8  then delete_carriage
      when 9  then move_forward!
      when 10 then move_back!
      when 11 then all_stations
      when 12 then trains_on_station
      when 13 then all_carriages
      when 14 then use_carriage
    else
      puts "Pleae enter a valid number."
    end
  end
############################################################################    Station
  def create_station
    puts "Station name:"
    name = gets.chomp
    self.stations << Station.new(name)
  end

  def all_stations
    self.stations.each.with_index(1) { |station, index| puts "#{index} - #{station.name}" }
  end

  def trains_on_station
    puts 'Choose a station:'
    all_stations
    choosen_station = gets.to_i - 1
    station = self.stations[choosen_station]
    station.trains.nil? ? "No trains" : station.each_train do |train|
      puts "Number: #{train.number}, Type: #{train.type}, Carriages: #{train.carriages.count}"
    end
  end

############################################################################    ROUTE
  def create_route
    system 'clear'
    puts "Choose the first and the last station:"
    all_stations
    choice1 = gets.to_i - 1
    choice2 = gets.to_i - 1
    self.routes << Route.new(self.stations[choice1], self.stations[choice2])
  end

  def all_routes
    self.routes.each.with_index(1) do |r, index|
      puts "#{index} - Route: #{r.stations[0].name} to #{r.stations[-1].name}"
    end
  end

  def add_station_to_route
    puts "Choose a route by its number:"
    all_routes
    route_choice = gets.to_i - 1

    puts "Choose a stations to add:"
    all_stations
    station_choice = gets.to_i - 1

    self.routes[route_choice].stations.insert(-2, self.stations[station_choice])
  end

  def delete_station_from_route
    puts "Choose a route by its index:"
    all_routes

    route_choice = gets.to_i - 1
    puts "Choose a station to delete:"
    self.routes[route_choice].stations.each.with_index(1) do |station, index|
      puts "#{index} - Station: #{station.name}"
    end

    delete_station = gets.to_i - 1
    self.routes[route_choice].stations.delete(delete_station)
  end

  def all_stops
    puts "Choose a route:"
    all_routes
    choice = gets.to_i - 1
    self.routes[choice].stations.each { |station| puts "#{station.name}" }
  end
############Check if it needed
def route_validate_create
  if self.stations.empty? || self.stations.size == 1
    puts "Atleast two stations must be created to create a route!"
  else
    create_route
  end
end

def new_station_validate_add
  if self.routes.empty?
    puts "A route must be created first!"
  else
    add_station_to_route
  end
end

def route_validate_delete
  if self.routes.empty?
    puts "A route must be created first!"
  else
    delete_station_from_route
  end
end

def route_validate_add
  if self.trains.empty? || self.routes.empty?
    puts 'Make sure you have at least one train and at least one route.'
  else
    add_route
  end
end
############################################################################    TRAIN
  def create_train
    puts "Train number:"
    number = gets.chomp
    type = nil
    until type == "P" || type == "C"
      puts "Choose a train type: P - Passenger, C - Cargo"
      type = gets.chomp
      if type == "P"
        self.trains << PassengerTrain.new(number)
      elsif type == "C"
        self.trains << CargoTrain.new(number)
      else
        puts "Please choose 'P' for  or 'C' for Cargo."
      end
    end
  end

  def train_list
    self.trains.each.with_index(1) do |train, index|
      puts "Index: #{index} - Train ##{train.number}, Train type: #{train.type}"
    end
  end

  def add_route
    puts "Choose a train by index:"

    train_list
    choosen_train = gets.to_i - 1

    puts "Choose a route:"
    all_routes
    choosen_route = gets.to_i - 1

    self.trains[choosen_train].set_route(self.routes[choosen_route])
      print "New route [#{self.routes[choosen_route].stations.first.name} - "
      print "#{self.routes[choosen_route].stations.last.name}]"
      print "Set for: ##{self.trains[choosen_train].number}."
    self.routes[choosen_route].stations.first.trains << self.trains[choosen_train]
  end

  def move_forward!
    puts "Choose a train by index:"
    train_list
    choosen_train = gets.to_i - 1
    if self.trains[choosen_train].next_station.nil?
      puts "The trains is at the final destination!"
    else
      puts "Previous station: #{self.trains[choosen_train].current_station.name}"
      self.trains[choosen_train].move_forward
      puts "Current station: #{self.trains[choosen_train].current_station.name}"
    end
  end

  def move_back!
    puts "Choose a train by index:"
    train_list
    choosen_train = gets.to_i - 1

    if self.trains[choosen_train].previous_station.nil?
      puts "The trains is at the statrting station!"
    else
      puts "Previous station: #{self.trains[choosen_train].current_station.name}"
      self.trains[choosen_train].move_back
      puts "Current station: #{self.trains[choosen_train].current_station.name}"
    end
  end
############################################################################    Carriage
  def add_carriage
    puts "Choose a train by the index:"
    train_list
    choosen_train = gets.to_i - 1

    if self.trains[choosen_train].type == :cargo
       puts "Total capacity of carriage:"
       capacity = gets.to_i
       self.trains[choosen_train].carriages << CargoCarriage.new(capacity)
    else
      puts "Number of seats:"
      seats = gets.to_i
      self.trains[choosen_train].carriages << PassengerCarriage.new(seats)
    end
      puts "Number of carriages: #{self.trains[choosen_train].carriages.count}"
  end

  def use_carriage
    puts "Choose a train by the index:"
    train_list
    choosen_train = gets.to_i - 1

    puts "Choose a carriage by index:"
    self.trains[choosen_train].all_carriages
    choosen_carriage = gets.to_i - 1

    if self.trains[choosen_train].type == :cargo
      puts "How much capacity you'd like to use?"
      used_capacity = gets.to_i
      self.trains[choosen_train].carriages[choosen_carriage].load(used_capacity)
    else
      self.trains[choosen_train].carriages[choosen_carriage].seat_taken
      puts "One seat was taken."
    end
  end

  def all_carriages
    puts "Choose a train by the index:"
    train_list
    choosen_train = gets.to_i - 1

    if self.trains[choosen_train].carriages.nil?
      "No carriage was added."
    elsif self.trains[choosen_train].type == :cargo
      self.trains[choosen_train].each_carriage do |carriage|
        puts "Type: #{carriage.type}, Capacity: #{carriage.total_capacity}"
      end
    else
      self.trains[choosen_train].each_carriage do |carriage|
        puts "Type: #{carriage.type}, Seats: #{carriage.total_seats}"
      end
    end
  end

  def delete_carriage
    puts "Choose train by index:"
    train_list
    choosen_train = gets.to_i - 1
    self.trains[choosen_train].carriages.delete_at(-1)
    puts "Number of carriages: #{self.trains[choosen_train].carriages.count}"
  end
end
