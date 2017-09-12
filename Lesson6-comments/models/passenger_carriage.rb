require_relative 'carriage.rb'

class PassengerCarriage < Carriage
  attr_reader :type

  def initialize
    @type = :passenger
  end
end
