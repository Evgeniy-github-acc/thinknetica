class Station
  include InstanceCounter
  include Validation

  attr_reader :name
  attr_accessor :trains_list

  @@station_instances = []

  def self.all 
    @@station_instances
  end
  
  def initialize(name)
    @name = name
    @trains_list = []
    @@station_instances << self
    register_instance
    validate!
  end

  def validate! 
    raise "Wrong name format" if name !~ /^[A-Z]{1}.+/
  end

  def train_arrive(train)
    trains_list << train
  end

  def trains_on_station
    trains_list.each { |train| puts train.number }
  end

  def train_depature(train)
    trains_list.delete(train)
  end

  def trains_types
    passenger = trains_list.select { |train| train.type == :passenger }
    cargo = trains_list.select { |train| train.type == :cargo }
    passenger.each { |i| puts "Passenger #{i.number}" }
    cargo.each { |i| puts "Cargo #{i.number}" }
  end
end
