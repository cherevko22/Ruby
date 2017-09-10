require_relative 'train'

class Cargo_train < Train
  attr_reader :type

  def initialize(number)
    @type = :cargo
    super
  end
end
