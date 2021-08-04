class Menu

    attr_accessor :trains, :cars, :stations, :routes

    def initialize
        @trains = []
        @cars = []
        @stations = []
        @routes = []
    end


    def show_trains
        puts "Trains:"
        @trains.each_with_index {|train, index| puts "#{index + 1}  |№ #{train.number}\t|carriages:  #{train.carriages.length}\t|type: \t#{train.type.to_s}"}
        puts "\n"
    end

    def show_stations
        puts "Stations: "
        @stations.each_with_index {|station, index| puts "#{index+1}\t#{station.name}\t|trains #{station.trains_list.size}"}
        puts "\n"
    end

    def show_cars
        puts "Carriages available: "
        @cars.each_with_index {|car, index| puts "#{index+1}  |№ #{car.number}\t|type:  #{car.type.to_s}"}
        puts "\n"
    end
    
    def show_routes
        puts "Routes available: "
        @routes.each_with_index {|route, index| puts " #{index+1} | #{route.first_station.name} - #{route.last_station.name}\t|"}
        puts "\n"
    end
    

    def set_items
    items = {
        1 => ' Create station',
        2 => ' Create train',
        3 => ' Create routes',
        4 => ' Create carriages',
        5 => ' Set route to train',
        6 => ' Add carriages to train',
        7 => ' Cut carriages',
        8 => ' Move train',
        9 => ' View trains on stations',
        10 => 'Exit'
    }
    end
  

  def show
    loop do 
    items = set_items
    items.each {|key, value| puts "#{key.to_s}  #{value}"}
    choise = gets.chomp
        if items.has_key? choise.to_i
           return choise
        else puts "Make a choise from the list above"
        end    
    end
   end   
   

  
    def create_train
        show_trains if @trains
        puts "Enter train number"
        number = gets.chomp
        puts "Enter train type
            1. Cargo
            2. Passenger"
        type = gets.chomp
            if type == '1'
                train = CargoTrain.new number
                @trains << train
            elsif type == '2'
                train = PassengerTrain.new number
                @trains << train
            else puts "Wrong type"
            end
    end

    def create_cars
        show_cars if @cars
        puts "Enter carriage number"
        number = gets.chomp
        puts "Enter carriage type
        1. Cargo
        2. Passenger"
        type = gets.chomp
        if type == '1'
            car = CarrigeCargo.new number
            @cars << car
        elsif type == '2'
            car = CarrigePassenger.new number
            @cars << car
        else puts "Wrong type"
        end
    end

    def add_cars
        if @cars.empty? || @trains.empty?
            puts "Create trains and cars first"
            gets
            self.navigate
        end   
        show_trains
        show_cars
        puts "Select train"
        train_list_number = gets.chomp.to_i - 1
        puts "Select carriage"
        car_list_number = gets.chomp.to_i - 1
        @trains[train_list_number].add_carriage @cars[car_list_number]
        @cars.delete_at(car_list_number) if @trains[train_list_number].carriage_fits? @cars[car_list_number]
    end

    def delete_cars
        show_trains
        puts "Select train"
        train_list_number = gets.chomp.to_i - 1
        train = @trains[train_list_number]
        train.carriages.each_with_index{|car, index| puts "#{index+1} |№ #{car.number}"} 
        puts "Select carriage"
        car_list_number = gets.chomp.to_i - 1
        car = train.carriages[car_list_number]
        train.cut_carriage car
        @cars << car
    end
      
    def create_station
        show_stations if @stations
        puts "Enter station name"
        name = gets.chomp
        station = Station.new name
        @stations << station
    end
    
    def station_trains_view
        show_stations if @stations
        puts "Select station"
        selected_station = gets.chomp.to_i - 1
        @stations[selected_station].trains_types
    end
   
    def create_route
        show_routes

        if @stations.size < 2
            puts "You need at least 2 stations to work with routes"
            return
        end

        puts "Enter: 
                1 to create route
                2 to add stations
                3 to delete stations
                4 to exit"
       
        choise = gets.chomp
       
        if choise == '1'        
            show_stations
            puts "Select first station"
            first_station_index = gets.chomp.to_i - 1
            puts "Select destination"
            last_station_index = gets.chomp.to_i - 1
            route = Route.new @stations[first_station_index], @stations[last_station_index]
            @routes << route
                
        elsif choise == '2'
            show_routes
            puts "Select route"
            route_index = gets.chomp.to_i - 1
            show_stations
            puts "Select station to add to route"
            station_index = gets.chomp.to_i - 1
            @routes[route_index].add_station @stations[station_index]

        elsif choise == '3'
            show_routes
            puts "Select route"
            route_index = gets.chomp.to_i - 1
            @routes[route_index].stations.each_with_index{|station, index| puts "#{index+1}  #{station.name}"}
            puts "Select station to delete from route"
            station_index = gets.chomp.to_i - 1
            @routes[route_index].delete_station @stations[station_index] 
             
        elsif choise == '4'
            return
        else
            puts "Wrong choise"
        end        
    end        
    
    def set_route_to_train
       if @trains.empty? || @routes.empty?
        puts "Create trains and routes first"
       else 
            show_trains
            puts "Select train"
            train_index = gets.chomp.to_i - 1
            show_routes
            puts "Select route"
            route_index = gets.chomp.to_i - 1
            @trains[train_index].set_route @routes[route_index]
       end
    end

    def move_train
       if @trains.empty? 
            puts "There is no trains to move"
       else
            show_trains
            puts "Select train to move"
            train_index = gets.chomp.to_i - 1
                if @trains[train_index].route == nil
                    puts "Train doesn't have actual route"
                else 
                    loop do
                        puts "Where are we going?: 1 - forward, 2- back, 3 - stop"
                        choise = gets.chomp
                            case choise
                                when '1'
                                    @trains[train_index].go_forward 
                                when '2'
                                     @trains[train_index].go_back 
                                when '3'
                                    break
                                else puts "Wrong choise"    
                            end
                    end     
                end 
        end
    end        
end