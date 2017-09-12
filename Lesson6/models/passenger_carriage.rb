require_relative 'carriage.rb'

class PassengerCarriage < Carriage

  def initialize
    @type = :passenger
  end
end
