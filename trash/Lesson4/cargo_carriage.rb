class Cargo_carriage
  include Manufacturer

  attr_reader :type

  def initialize
    @type = :cargo
  end
end
