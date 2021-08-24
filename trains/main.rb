# frozen_string_literal: true

require_relative 'modules/accessors.rb'
require_relative 'interface/train_methods'
require_relative 'interface/station_methods'
require_relative 'interface/route_methods'
require_relative 'interface/carriage_methods'
require_relative 'interface/menu'
require_relative 'manage'
require_relative 'modules/validation'
require_relative 'modules/instance_counter'
require_relative 'modules/producer'
require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

main_menu = Menu.new
train_menu = Menu.new
carriage_menu = Menu.new
station_menu = Menu.new
route_menu = Menu.new

manage = Manage.new

train_menu.items = Items.new
train_menu.items.functions = { 'View' => proc { manage.show_trains },
                               'Create' => proc { manage.create_train },
                               'Add Carriage' => proc { manage.add_carriages },
                               'Delete Carriage' => proc { manage.delete_carriages },
                               'View Carriages on Trains' => proc { manage.show_trains_carriages },
                               'Set Route' => proc { manage.route_to_train },
                               'Move' => proc { puts manage.move_train_menu },
                               'Back' => proc { main_menu.navigate } }

carriage_menu.items = Items.new
carriage_menu.items.functions = { 'View' => proc { manage.show_carriages(manage.carriages) },
                                  'Create' => proc { manage.create_carriage },
                                  'Load' => proc { manage.fill_carriages },
                                  'Back' => proc { main_menu.navigate } }

station_menu.items = Items.new
station_menu.items.functions = { 'View' => proc { manage.station_trains_view },
                                 'Create' => proc { manage.create_station },
                                 'Back' => proc { main_menu.navigate } }

route_menu.items = Items.new
route_menu.items.functions = { 'View' => proc { manage.show_routes },
                               'Create' => proc { manage.create_route },
                               'Add stations' => proc { manage.add_station_route },
                               'Delete stations' => proc { manage.delete_station_route },
                               'Back' => proc { main_menu.navigate } }

main_menu.items = Items.new
main_menu.items.functions = { 'Trains' => proc { train_menu.navigate },
                              'Carriages' => proc { carriage_menu.navigate },
                              'Stations' => proc { station_menu.navigate },
                              'Routes' => proc { route_menu.navigate },
                              'Exit' => proc { exit } }

main_menu.navigate
