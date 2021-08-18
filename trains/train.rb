# frozen_string_literal: true

class Train
  include Producer
  include InstanceCounter
  include Validation

  attr_reader :number, :type
  attr_accessor :route, :carriages, :station, :speed

  @@trains = []

  def number_format
    /^[a-z0-9]{3}-?[a-z0-9]{2}/i
  end

  def self.find(number)
    @@train_instances.find { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    validate!
    @@trains << self
    register_instance
  end

  def carriage_fits?(carriage)
    carriage.type == type
  end

  def add_carriage(carriage)
    raise 'You must stop first' unless speed.zero?
    raise "You can't use this type of carriage for this train" unless carriage_fits?(carriage)

    carriages << carriage if speed.zero? && carriage_fits?(carriage)
  end

  def stop
    self.speed = 0
  end

  def cut_carriage(carriage)
    raise 'You must stop first' unless speed.zero?
    raise 'There is no carriages' if carriages.empty?

    carriages.delete(carriage)
  end

  def route_set(route)
    self.route = route
    self.station = route.stations.first
    station.train_arrive(self)
  end

  def go_forward
    next_station
    raise 'The last station!' unless next_station

    following = next_station
    @station.train_depature(self)
    following.train_arrive(self)
    self.station = following
  end

  def go_back
    previous_station
    raise 'The first station!' unless previous_station

    previous = previous_station
    station.train_depature(self)
    previous.train_arrive(self)
    self.station = previous
  end

  def validate!
    raise 'Object number has invalid format try to create again' if number !~ number_format
  end

  def take_each_carriage(&block)
    carriages.each { |carriage| block.call(carriage) }
  end

  private

  def next_station
    station == route.stations.last ? nil : route.stations[route.stations.index(station) + 1]
  end

  def previous_station
    station == route.stations.first ? nil : route.stations[route.stations.index(station) - 1]
  end
end
