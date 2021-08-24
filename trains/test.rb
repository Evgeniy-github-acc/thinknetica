# frozen_string_literal: true

require_relative 'modules/accessors.rb'
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

kiev = Station.new "Kiev"
Station.attr_accessor_with_history('passengers', 'tickets')
kiev.passengers= 20
kiev.tickets= 70
kiev.passengers= 30
kiev.tickets= 90
kiev.passengers= 40
kiev.tickets= 20
puts kiev.tickets_history
puts kiev.passengers_history