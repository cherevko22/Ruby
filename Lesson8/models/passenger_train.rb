require_relative 'train.rb'

class PassengerTrain < Train

  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end
end
