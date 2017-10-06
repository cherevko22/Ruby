class Station
  include Validation

  attr_reader :name, :trains

  NAME_PATTERN = /^[A-Z]{2,3}$/

  validate :name, :presence
  validate :name, :format, NAME_PATTERN

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
  end

  def each_train(&block)
    self.trains.each { |train| block.call(train) }
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

end
