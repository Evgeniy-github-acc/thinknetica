class Route
  attr_reader :first_station, :last_station 
  attr_accessor :stations
    
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
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