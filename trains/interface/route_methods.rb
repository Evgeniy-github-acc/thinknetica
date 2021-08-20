# frozen_string_literal: true

module RouteMethods
  def show_routes
    puts 'Routes available: '
    unless routes.empty?
      routes.each_with_index do |route, index|
        puts " #{index + 1} | #{route.stations.first.name} - #{route.stations.last.name}\t|"
      end
    end
    puts
  end

  def select_route
    show_routes
    puts 'Select route'
    route_index = gets.chomp.to_i - 1
    routes[route_index]
  end

  def create_route
    if stations.size < 2
      puts 'You need at least 2 stations to create routes'
      return
    end
    puts 'Select first station'
    first_station = select_station
    puts 'Select destination'
    last_station = select_station
    route = Route.new(first_station, last_station)
    routes << route
  end

  def add_station_route
    route = select_route
    station = select_station
    route.add_station(station)
  end

  def delete_station_route
    route = select_route
    station = select_station
    route.delete_station(station)
  end
end
