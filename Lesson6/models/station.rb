class Station
  include Validator

  attr_reader :name, :trains

  NAME_PATTERN = /^[A-Z]{2,3}$/

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
  end

  def self.all
    @@stations
  end

  def incoming(train)
    @trains << train
  end

  def by_type(type)
    @trains.select.count { |train| train.type if train.type == type}
  end

  def all_trains
    @trains.each { |train| puts "Train number: #{train.number}." }
  end

  def departure(train)
    @trains.delete(train)
  end

  protected

  def validate!
    raise "Please enter a name." if name.nil?
    raise "Name must have 2 or 3 capital letters." if name !~ NAME_PATTERN
    true
  end

end
