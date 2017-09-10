require_relative 'train.rb'

class Cargo < Train

  def initialize(number)
    super
    @type = :cargo
  end

end
