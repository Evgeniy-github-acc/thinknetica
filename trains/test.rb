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


#Accessors Module demonstration 
kiev = Station.new "Kiev"
Station.attr_accessor_with_history('passengers', 'tickets')
kiev.passengers= 20
kiev.tickets= 70
kiev.passengers= 30
kiev.tickets= 90
kiev.passengers= 40
kiev.tickets= 20
print kiev.tickets_history
print kiev.passengers_history
puts

#Validation Module demonstration 
begin
  first = Train.new(123) # Erorr "Wrong type" will be raised  
rescue => exception
  puts "Exception: #{exception.inspect}"
end

begin
  first = Train.new('123')  # Erorr "Wrong format" will be raised 
rescue => exception
  puts "Exception: #{exception.inspect}"
end

first = Train.new('123-12') #Object will be created

   