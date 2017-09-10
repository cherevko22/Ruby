require_relative 'train'

class Passenger_train < Train

  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end
end
