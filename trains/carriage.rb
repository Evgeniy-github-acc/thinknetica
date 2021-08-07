class Carriage
  include Producer
  
  attr_reader :number, :type, :type

  def initialize(number)
    @number = number
  end
end
