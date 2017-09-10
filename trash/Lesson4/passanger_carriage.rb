class Passang_carriage
  include Manufacturer

  attr_reader :type

  def initialize
    @type = :passenger
  end
end
