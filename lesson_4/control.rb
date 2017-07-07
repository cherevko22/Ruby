class Controller
  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end
###################################Menu&Action################################################################################################
  def menu
    system 'clear'
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
  end

  def menu_choice (user_choice)
    case user_choice
      when 1
        create_station
      when 2
        create_train
      when 3
        if @stations.nil? || @stations.size == 1
          puts "Atleast two stations must be created to create a route!"
        else
          create_route
        end
      when 4
        if @routes.nil?
          puts "A route must be created first!"
        else
          add_station_to_route
        end
      when 5
        if @routes.nil?
          puts "A route must be created first!"
        else
          delete_station_from_route
        end
      when 6
        #A train and a route must be created
        if @trains.nil? || @routes.nil?
          puts "Make sure you have at least one train and at least one route."
        else
          add_route!
        end
      when 7
        add_carriage
      when 8
        delete_carriage
      when 9
        next_station!
      when 10
        previous_station!
      when 11
        all_stations
      when 12
        trains_on_station
    else
      puts "Pleae enter a valid number."
    end
  end
###################################Station####################################################################################################
  def create_station
    puts "Station name:"
    name = gets.chomp
    @stations << Station.new(name)
  end

  def all_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end

  def trains_on_station                   #Check!
    puts "Choose a station:"
    all_stations
    choosen_station = gets.to_i - 1
    @stations[choosen_station].trains.each do |train|
      if @stations[choosen_station].trains.nil?
        puts "No trains at this station."
      else
        puts "Currently on this station is train number: #{train.number}"
      end
    end
  end
###################################ROUTE######################################################################################################
  def create_route
    system 'clear'
    puts "Choose the first and the last station from the list:"
    all_stations
    choice1 = gets.to_i - 1
    choice2 = gets.to_i - 1
    @routes << Route.new(self.stations[choice1], self.stations[choice2])
    puts "Route [#{self.stations[choice1].name} to #{self.stations[choice2].name}] was created."
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
    puts "Choose a route by its number:"
    all_routes
    route_choice = gets.to_i - 1

    puts "Choose a station to delete:"
    @routes[route_choice].stations.each.with_index(1) do |station, index|
      puts "#{index} - Station: #{station.name}"
    end
    delete_station = gets.to_i - 1
    @routes[route_choice].stations.delete_at(delete_station)
  end

  def all_routes
    @routes.each.with_index(1) do |route, index|
      puts "#{index} - Route: #{route.stations[0].name} to #{route.stations[-1].name}"
    end
  end

  def all_stops
    puts "Choose a route:"
    all_routes
    choice = gets.to_i - 1
    self.routes[choice].stations.each { |station| puts "#{station.name}"  }
  end
###################################TRAIN######################################################################################################
  def create_train
    puts "Train number:"
    number = gets.chomp
    type = nil
    until type == "P" || type == "C" do
      puts "Choose a train type: P - Passnger, C - Cargo"
      type = gets.chomp
      if type == "P"
        @trains << Passanger.new(number)
      elsif type == "C"
        @trains << Cargo.new(number)
      else
        puts "Please choose P for Passanger or C for Cargo."
      end
    end
  end

  def train_list
    @trains.each.with_index(1) do |train, index|
      puts "Index: #{index} - Train Number: #{train.number}, Train Type: #{train.type}"
    end
  end

  def add_route!   #Name might need to be changed
    puts "Choose a train by index:"
    train_list
    choosen_train = gets.to_i - 1
    puts "Choose a route:"
    all_routes
    choosen_route = gets.to_i - 1
    @trains[choosen_train].add_route(@routes[choosen_route])
    puts "New route [#{@routes[choosen_route].stations.first.name} - #{@routes[choosen_route].stations.last.name}] was set for train ##{@trains[choosen_train].number}."
    @routes[choosen_route].stations.first.trains << @trains[choosen_train]
  end

  def next_station!
    puts "Choose a train by index:"
    train_list
    choosen_train = gets.to_i - 1
    if @trains[choosen_train].next_station.nil?
      puts "The trains is at the final destination!"
    else
      puts "Previous station: #{@trains[choosen_train].current_station.name}"
      @trains[choosen_train].move_forward
      puts "Current station: #{@trains[choosen_train].current_station.name}"
    end
  end

  def previous_station!
    puts "Choose a train by index:"
    train_list
    choosen_train = gets.to_i - 1
    if @trains[choosen_train].previous_station.nil?
      puts "The trains is at the statrting destination!"
    else
      puts "Previous station: #{@trains[choosen_train].current_station.name}"
      @trains[choosen_train].move_back
      puts "Current station: #{@trains[choosen_train].current_station.name}"
    end
  end

###################################Carriage###################################################################################################
  def add_carriage
    puts "Choose a train by the index:"
    train_list
    choosen_train = gets.to_i - 1
    if @trains[choosen_train].type == :cargo
       @trains[choosen_train].carriages << CargoCarriage.new
    else
      @trains[choosen_train].carriages << PassangerCarriage.new
    end
    puts "Number of carriages: #{@trains[choosen_train].carriages.count}"
  end

  def delete_carriage
    puts "Choose train by index:"
    train_list
    choosen_train = gets.to_i - 1
    @trains[choosen_train].carriages.delete_at(-1)
    puts "Number of carriages: #{@trains[choosen_train].carriages.count}"
  end


end
