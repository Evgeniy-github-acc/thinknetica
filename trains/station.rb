# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation
  extend Accessors
  
  attr_reader :name
  attr_accessor :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.validate('name', 'attr_type', String)
    self.class.validate('name', 'attr_format', /^[A-Z]{1}.+/)
    validate!
    @@stations << self
    register_instance
  end

 # def validate!
  # raise 'Wrong name format' if name !~ /^[A-Z]{1}.+/
  #end

  def train_arrive(train)
    trains << train
  end

  def trains_on_station
    trains.each { |train| puts train.number }
  end

  def train_depature(train)
    trains.delete(train)
  end

  def take_each_train(&block)
    trains.each { |train| block.call(train) }
  end

  def trains_types
    passenger = trains.select { |train| train.type == :passenger }
    cargo = trains.select { |train| train.type == :cargo }
    passenger.each { |i| puts "Passenger #{i.number}" }
    cargo.each { |i| puts "Cargo #{i.number}" }
  end
end
