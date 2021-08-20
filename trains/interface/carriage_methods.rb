# frozen_string_literal: true

module CarriageMethods
  def show_carriages(carriages)
    puts 'Carriages available: '
    unless carriages.empty?
      carriages.each_with_index do |carriage, index|
        puts "#{index + 1}  |№ #{carriage.number}\t|type:  #{carriage.type}"
      end
    end
    puts
  end

  def select_carriage(carriages)
    show_carriages(carriages)
    puts 'Select carriage'
    carriage_index = gets.chomp.to_i - 1
    carriages[carriage_index]
  end

  def create_carriage
    puts 'Select carriage type'
    menu.items.functions = { 'Cargo' => proc { create_cargo_carriage },
                             'Passenger' => proc { create_passenger_carriage },
                             'Back' => proc { return } }
    menu.navigate
  end

  def create_cargo_carriage
    puts 'Enter carriage number'
    number = gets.chomp
    puts 'Enter capacity: '
    volume = gets.chomp.to_f
    carriage = CargoCarriage.new(number, volume)
    carriages << carriage
  end

  def create_passenger_carriage
    puts 'Enter carriage number'
    number = gets.chomp
    puts 'How much seats?: '
    seats = gets.chomp.to_i
    carriage = PassengerCarriage.new(number, seats)
    carriages << carriage
  end

  def add_carriages
    if @carriages.empty? || @trains.empty?
      puts 'Create trains and cars first'
      return
    end
    train = select_train
    carriage = select_carriage(carriages)
    train.add_carriage(carriage)
    carriages.delete(carriage) if train.carriage_fits?(carriage)
  end

  def delete_carriages
    train = select_train
    carriage = select_carriage(train.carriages)
    train.cut_carriage(carriage)
    carriages << carriage
  end

  def fill_carriages
    carriage = select_carriage(carriages)
    case carriage.type
    when :cargo
      fill_cargo_carriage(carriage)
    when :passenger
      fill_passenger_carriage(carriage)
    end
  end

  def fill_cargo_carriage(carriage)
    puts 'How much to load?'
    volume = gets.chomp.to_f
    begin
      carriage.load(volume)
    rescue RuntimeError => e
      puts "Exception: #{e.inspect}"
      puts e.backtrace
    end
  end

  def fill_passenger_carriage(carriage)
    carriage.take_seat
    puts "One seat taken, #{carriage.free_seats} free"
  rescue RuntimeError => e
    puts "Exception: #{e.inspect}"
    puts e.backtrace
  end
end
