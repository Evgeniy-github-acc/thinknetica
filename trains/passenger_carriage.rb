class PassengerCarriage < Carriage
  attr_reader :max_seats
  attr_accessor :filled_seats
  
  def initialize(number, max_seats)
    @number = number
    @type = :passenger
    @max_seats = max_seats
    @filled_seats = 0
    validate!
  end

  def take_seat
    raise "Carriage is full" if filled_seats == max_seats
    @filled_seats += 1
  end

  def free_seats
    max_seats - filled_seats
  end
end