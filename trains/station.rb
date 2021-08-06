class Station
  attr_reader :name
  attr_accessor :trains_list

  def initialize (name)
    @name = name
    @trains_list = []
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
