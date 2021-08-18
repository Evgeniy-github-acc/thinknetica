class Menu
  attr_accessor :trains, :cars, :stations, :routes

  def initialize
    @trains = []
    @cars = []
    @stations = []
    @routes = []
  end

  def show_trains
    puts 'Trains:'
    trains.each_with_index { |train, index| puts "#{index + 1}  |№ #{train.number}\t|carriages:  #{train.carriages.length}\t|type: \t#{train.type.to_s}" } unless trains.empty?
    puts
  end

  def show_stations
    puts 'Stations: '
    stations.each_with_index { |station, index| puts "#{index + 1}\t#{station.name}\t|trains #{station.trains.size}" } unless stations.empty?
    puts
  end

  def show_cars
    puts 'Carriages available: '
    cars.each_with_index { |car, index| puts "#{index + 1}  |№ #{car.number}\t|type:  #{car.type.to_s}" } unless cars.empty?
    puts
  end
    
  def show_routes
    puts 'Routes available: '
    routes.each_with_index { |route, index| puts " #{index + 1} | #{route.stations.first.name} - #{route.stations.last.name}\t|" } unless routes.empty?
    puts
  end
  
  def show_trains_cars
    trains.each do |train| 
      puts "#{train.number}  "
      if train.carriages.empty?
        puts "Train is empty"
      else
        puts "#{train.carriages.length} cars "  
        case train.type
        when :cargo      
          train.take_each_carriage { |carriage| puts "#{carriage.number} type: #{carriage.type} filed #{carriage.filled_volume} free #{carriage.free_volume}" }
        when :passenger
          train.take_each_carriage { |carriage| puts "#{carriage.number} type: #{carriage.type} filed #{carriage.filled_seats} free #{carriage.free_seats}" }
        end
      end 
    end
  end

  def station_trains_view
    stations.each do |station| 
      puts "#{station.name}  "
      if station.trains.empty?
        puts "Station is empty"
      else
      station.take_each_train { |train| puts "#{train.number} #{train.type}  #{train.carriages.length}" }
      end 
    end
  end
  
  def items
    {
      1 => ' Create station',
      2 => ' Create train',
      3 => ' Create routes',
      4 => ' Create carriages',
      5 => ' Set route to train',
      6 => ' Add carriages to train',
      7 => ' Cut carriages',
      8 => ' Move train',
      9 => ' View trains on stations',
      10 => ' View carriages on trains',
      11 => 'Fill carriages',
      12 => 'Exit'
    }
  end

  def show
    loop do
      items.each { |key, value| puts "#{key}  #{value}" }
      choise = gets.chomp.to_i
      return choise if items.key?(choise)

      puts 'Make a choise from the list above'
    end
  end
  
  def create_station
    show_stations if @stations
    puts 'Enter station name'
    name = gets.chomp
    station = Station.new(name)
    stations << station
  end

  def create_train
    show_trains
    puts 'Enter train number'
    number = gets.chomp
    puts 'Enter train type
            1. Cargo
            2. Passenger'
    type = gets.chomp
    
    begin
    case type
    when '1' 
    train = CargoTrain.new number
      trains << train
      puts "Train #{train.type.to_s} number #{train.number.to_s} created"
    when '2'
      train = PassengerTrain.new number
      trains << train
      puts "Train #{train.type.to_s} number #{train.number.to_s} created"
    end
    rescue RuntimeError => error
      puts "Exception: #{error.inspect}"
      puts error.backtrace
    end  
  end

  def create_route
    show_routes
    if stations.size < 2
      puts 'You need at least 2 stations to work with routes'
      return
    end
    puts 'Enter:
                1 to create route
                2 to add stations
                3 to delete stations
                4 to exit'
    choise = gets.chomp
    case choise 
    when '1'
      show_stations
      puts 'Select first station'
      first_station_index = gets.chomp.to_i - 1
      puts 'Select destination'
      last_station_index = gets.chomp.to_i - 1
      route = Route.new(stations[first_station_index], stations[last_station_index])
      routes << route
    when '2'
      show_routes
      puts 'Select route'
      route_index = gets.chomp.to_i - 1
      show_stations
      puts 'Select station to add to route'
      station_index = gets.chomp.to_i - 1
      routes[route_index].add_station(stations[station_index])
    when '3'
      show_routes
      puts 'Select route'
      route_index = gets.chomp.to_i - 1
      routes[route_index].stations.each_with_index { |station, index| puts "#{index + 1}  #{station.name}" }
      puts 'Select station to delete from route'
      station_index = gets.chomp.to_i - 1
      routes[route_index].delete_station(stations[station_index])
    when '4'
      return
    else
      puts 'Wrong choise'
    end
  end

  def create_cars
    show_cars
    puts 'Enter carriage type
        1. Cargo
        2. Passenger'
    type = gets.chomp
    puts 'Enter carriage number'
    number = gets.chomp
    if type == '1'
      puts "Enter capacity: "
      volume = gets.chomp.to_f
      car = CargoCarriage.new(number, volume)
      cars << car
    elsif type == '2'
      puts "How much seats?: "
      seats = gets.chomp.to_i
      car = PassengerCarriage.new(number, seats)
      cars << car
    else puts 'Wrong type'
    end
  end

  def set_route_to_train
    if trains.empty? || routes.empty?
      puts 'Create trains and routes first'
    else 
      show_trains
      puts 'Select train'
      train_index = gets.chomp.to_i - 1
      show_routes
      puts 'Select route'
      route_index = gets.chomp.to_i - 1
      trains[train_index].route_set(routes[route_index])
    end
  end

  def add_cars
    if @cars.empty? || @trains.empty?
      puts 'Create trains and cars first'
      return
    end   
    show_trains
    show_cars
    puts 'Select train'
    train_list_index = gets.chomp.to_i - 1
    puts 'Select carriage'
    car_list_index = gets.chomp.to_i - 1
    trains[train_list_index].add_carriage(cars[car_list_index])
    cars.delete_at(car_list_index) if trains[train_list_index].carriage_fits?(cars[car_list_index])
  end

  def delete_cars
    show_trains
    puts 'Select train'
    train_list_index = gets.chomp.to_i - 1
    trains[train_list_index].carriages.each_with_index { |car, index| puts "#{index + 1} |№ #{car.number}" }
    puts 'Select carriage'
    car_list_index = gets.chomp.to_i - 1
    train = trains[train_list_index]
    train.cut_carriage(train.carriages[car_list_index])
    cars << train.carriages[car_list_index]
  end
      
  def move_train
    if trains.empty?
      puts 'There is no trains to move'
    else
      show_trains
      puts 'Select train to move'
      train_index = gets.chomp.to_i - 1
        if trains[train_index].route.nil?
          puts "Train doesn't have actual route"
        else 
          loop do
            puts 'Where are we going?: 1 - forward, 2- back, 3 - stop'
            choise = gets.chomp
            case choise
            when '1'
              trains[train_index].go_forward 
            when '2'
              trains[train_index].go_back 
            when '3'
              break
            else puts 'Wrong choise'
            end
          end
        end
    end
  end

  def fill_cars
    show_cars
    puts 'Select car'
    selected_car = gets.chomp.to_i - 1
    case cars[selected_car].type
    when :cargo
      puts "How much to load?"
      volume = gets.chomp.to_f
      cars[selected_car].load(volume)
    when :passenger
      cars[selected_car].take_seat
      puts "One seat taken, #{cars[selected_car].free_seats} free"
    end
  end

end
