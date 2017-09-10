require_relative 'modules/manufacturer.rb'

class PassangerCarriage

  include Manufacturer

  attr_reader :type

  def initialize
    @type = :passenger
  end

end
