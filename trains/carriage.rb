class Carriage
  include Producer
  include Validation
  
  attr_reader :number, :type

  def initialize(number)
    @number = number
    validate!
  end
end
