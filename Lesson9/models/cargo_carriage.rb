require_relative 'carriage.rb'

class CargoCarriage < Carriage

  attr_accessor :available_capacity, :loaded_capacity
  attr_reader :total_capacity

  def initialize(total_capacity)
    @type = :cargo
    @total_capacity = total_capacity
    @available_capacity = total_capacity
  end

  def load(loaded)
    self.available_capacity -= loaded
  end

end
