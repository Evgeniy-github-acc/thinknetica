module Validation
  def valid?
    validate!
  rescue
    false
  end
 
  protected
  def validate!
    raise "Train number has invalid format try to create train again"   if number !~ self.number_format
    #raise "Type should be :cargo or :passenger only" if type != :cargo || type != :passenger
  end
end