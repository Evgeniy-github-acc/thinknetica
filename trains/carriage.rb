class Carriage
  include Producer
  include Validation
  
  attr_reader :number, :type

  def initialize(number)
    @number = number
    validate!
  end

  def number_format
    number_format = /^[a-z0-9]{3}-?[a-z0-9]{2}/i
  end
  
  def validate!
    raise "Object number has invalid format try to create again"   if number !~ self.number_format
  end  

end
