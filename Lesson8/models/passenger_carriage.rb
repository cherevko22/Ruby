require_relative 'carriage.rb'

class PassengerCarriage < Carriage
  attr_accessor  :taken_seats, :available_seats
  attr_reader :total_seats

  def initialize(total_seats)
    @type = :passenger
    @total_seats = total_seats
    @taken_seats = 0
    @available_seats = total_seats
  end

  def seat_taken
    self.taken_seats += 1
    self.available_seats -= 1
  end

end
