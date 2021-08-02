class PassengerTrain < Train
  
  def initialize type
    super 
    @type = :passenger
  end
end