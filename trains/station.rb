class Station
  include InstanceCounter
  include Validation

  attr_reader :name
  attr_accessor :trains

  @@stations = []

  def self.all 
    @@stations
  end
  
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def validate! 
    raise "Wrong name format" if name !~ /^[A-Z]{1}.+/
  end

  def train_arrive(train)
    trains << train
  end

  def trains_on_station
    trains.each { |train| puts train.number }
  end

  def train_depature(train)
    trains.delete(train)
  end

  def trains_types
    passenger = trains.select { |train| train.type == :passenger }
    cargo = trains.select { |train| train.type == :cargo }
    passenger.each { |i| puts "Passenger #{i.number}" }
    cargo.each { |i| puts "Cargo #{i.number}" }
  end
end