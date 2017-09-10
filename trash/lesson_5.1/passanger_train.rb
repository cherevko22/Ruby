require_relative 'train.rb'

class Passanger < Train

  def initialize(number)
    super
    @type = :passanger
  end

end
