# frozen_string_literal: true

module TrainMethods
  def show_trains
    puts 'Trains:'
    trains&.each_with_index do |train, index|
      puts "#{index + 1}  |№ #{train.number}\t|carriages:  #{train.carriages.length}\t|type: \t#{train.type}"
    end
    puts
  end

  def select_train
    show_trains
    puts 'Select train '
    train_index = gets.chomp.to_i - 1
    trains[train_index]
  end

  def show_cargo_train_carriages(train)
    train.take_each_carriage do |carriage|
      puts "#{carriage.number} - #{carriage.type} filed #{carriage.filled_volume} free #{carriage.free_volume}"
    end
  end

  def show_passenger_train_carriages(train)
    train.take_each_carriage do |carriage|
      puts "#{carriage.number} - #{carriage.type} filed #{carriage.filled_seats} free #{carriage.free_seats}"
    end
  end

  def show_trains_carriages
    trains.each do |train|
      puts "#{train.number} - #{train.carriages.length} carriages"
      case train.type
      when :cargo
        show_cargo_train_carriages(train)
      when :passenger
        show_passenger_train_carriages(train)
      end
    end
  end

  def create_train
    puts 'Select train type'
    menu.items.functions = { 'Cargo' => proc { create_cargo_train },
                             'Passenger' => proc { create_passenger_train },
                             'Back' => proc { return } }

    menu.navigate
  end

  def create_cargo_train
    puts 'Enter number'
    number = gets.chomp
    begin
      train = CargoTrain.new number
      trains << train
      puts "Train #{train.type} number #{train.number} created"
    rescue RuntimeError => e
      puts "Exception: #{e.inspect}"
      puts e.backtrace
    end
  end

  def create_passenger_train
    puts 'Enter number'
    number = gets.chomp
    begin
      train = PassengerTrain.new number
      trains << train
      puts "Train #{train.type} number #{train.number} created"
    rescue RuntimeError => e
      puts "Exception: #{e.inspect}"
      puts e.backtrace
    end
  end

  def route_to_train
    if trains.empty? || routes.empty?
      puts 'Create trains and routes first'
    else
      train = select_train
      route = select_route
      train.route_set(route)
    end
  end

  def move_train_menu
    if trains.empty?
      puts 'There is no trains to move'
    else
      train = select_train
      if train.route.nil?
        puts "Train doesn't have actual route"
      else
        move_train(train)
      end
    end
  end

  def move_train(train)
    puts 'Where are we going?: 1 - forward, 2- back, 3 - stop'
    menu.items.functions = { 'Forward' => proc { train.go_forward },
                             'Back' => proc { train.go_back },
                             'Stop' => proc { return } }
    menu.navigate
  end
end
