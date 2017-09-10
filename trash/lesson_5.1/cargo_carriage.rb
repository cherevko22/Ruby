class CargoCarriage
  
  include Manufacturer

  attr_reader :type

  def initialize
    @type = :cargo
  end

end
