class Route
  include InstanceCounter
  include Validation

  attr_accessor :stations
    
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def validate!
    raise "Station doesn't exist" unless Station.all.include? stations.first && stations.last
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def show_stations
    stations.each { |station| puts station.name }
  end    
end