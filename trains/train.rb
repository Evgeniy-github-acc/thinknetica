class Train
  attr_reader :number, :type
  attr_accessor :route, :carriages, :station, :speed
    
  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    @type = 0
  end

  def carriage_fits?(carriage)
    carriage.type == self.type
  end

  def add_carriage(carriage)
    puts 'You must stop first' unless @speed.zero?
    puts "You can't use this type of carriage for this train" unless carriage_fits?(carriage) 
    @carriages << carriage if @speed.zero? && carriage_fits?(carriage)
  end

  def stop
    self.speed = 0
  end
        
  def cut_carriage(carriage)
    if @carriages.!empty?
      if @speed.zero?
        carriages.delete(carriage)
      else puts 'You must stop first'
      end
    else puts 'There is no carriages'
    end
  end
        
  def set_route(route)
    @route = route
    @station = route.first_station
    @station.train_arrive self
  end

  def go_forward
    next_station = get_stations.last
    if next_station
      @station.train_depature(self)
      next_station.train_arrive(self)
      self.station = next_station
    else
      puts 'The last station! Go back or set the new route'
    end
  end

  def go_back
    previous_station = get_stations.first
    if previous_station
      @station.train_depature(self)
      previous_station.train_arrive(self)
      self.station = previous_station
    else
      puts 'The first station! Go forward or set the new route'
    end
  end
  
  private

# Метод помещен в private, так как является внутренним методом класса, не вызывается его экземплярами и в его наследниках
  def get_stations
    current_station = @station
    current_station == @route.last_station ? next_station = nil : next_station = @route.stations[@route.stations.index(@station) + 1]
    current_station == @route.first_station ? previous_station = nil : previous_station = @route.stations[@route.stations.index(@station) - 1]
    [previous_station, current_station, next_station]
  end
end
