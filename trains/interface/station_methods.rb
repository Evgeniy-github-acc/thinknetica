# frozen_string_literal: true

module StationMethods
  def show_stations
    puts 'Stations: '
    unless stations.empty?
      stations.each_with_index do |station, index|
        puts "#{index + 1}\t#{station.name}\t|trains #{station.trains.size}"
      end
    end
    puts
  end

  def select_station
    show_stations
    puts 'Select station'
    station_index = gets.chomp.to_i - 1
    stations[station_index]
  end

  def station_trains_view
    stations.each do |station|
      puts "#{station.name}  "
      if station.trains.empty?
        puts 'Station is empty'
      else
        station.take_each_train { |train| puts "#{train.number} #{train.type}  #{train.carriages.length}" }
      end
    end
  end

  def create_station
    show_stations if @stations
    puts 'Enter station name'
    name = gets.chomp
    station = Station.new(name)
    stations << station
  end
end
