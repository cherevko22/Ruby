class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
