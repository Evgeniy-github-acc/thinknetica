class PassengerTrain < Train
  def initialize(type)
    @type = :passenger
    super 
  end
end