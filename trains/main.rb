require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'route.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'carriage.rb'
require_relative 'carriage_cargo.rb'
require_relative 'carriage_passenger.rb'
require_relative 'main_menu.rb'

menu = Menu.new

loop do
    case menu.show
        when '1' 
            menu.create_station 
        when '2'
            menu.create_train
        when '3'
            menu.create_route
        when '4'
            menu.create_cars
        when '5' 
             menu.set_route_to_train
        when '6'
            menu.add_cars
        when '7'
            menu.delete_cars
        when '8'
            menu.move_train    
        when '9' 
             menu.station_trains_view
        when '10'
            exit
    end
end        



