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
train_menu = TrainMenu.new
station_menu = SationsMenu.new
routes_menu = RoutesMenu.new
case menu.show 
    when '1' 
        train_menu.navigate 
    when '2'
        station_menu.show
    when '3'
        routes_menu.show
    when '4'
        exit
end
        



