require_relative 'carriage.rb'

class CargoCarriage < Carriage
  attr_reader :type

  def initialize
    @type = :cargo
  end

end
