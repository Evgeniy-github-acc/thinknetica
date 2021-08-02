class Menu
  
    def set_items
    items = {
        1 => 'Trains',
        2 => 'Stations',
        3 => 'Routes',
        4 => 'Exit',
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

end

class TrainMenu < Menu

    def initialize
        @trains = []
    end

    def show_trains
        @trains.each {|train| puts "№ #{train.number}, type #{train.type.to_s}, cars #{train.carriages.length}"}
    end
    
    def set_items
        items = {
            1 => 'Create train',
            2 => 'Add cars',
            3 => 'Delete cars',
            4 => 'Move train',
            5 => 'Previous menu',
        }
    end

    def show
        show_trains if @trains
        super
    end    


    def get_choise
        @choise = self.show
    end
    
    def create_train
        puts "Enter train number"
        number = gets.chomp
        puts "Enter train type
            1. Cargo
            2. Passenger"
        type = gets.chomp
            if type == '1'
                train = CargoTrain.new number
            elsif type == '2'
                train = PassengerTrain.new number
            else puts "Wrong type"
            end
        @trains << train
        navigate
    end
    
    def navigate 
        choise = get_choise
        case choise
            when '1'
            create_train
        end    
    end    


end

class SationsMenu < Menu
    def set_items
        items = {
            1 => 'Create station',
            2 => 'View trains on station',
            3 => 'Previous menu',
        }
    end
end

class RoutesMenu < Menu
    def set_items
        items = {
            1 => 'Create route',
            2 => 'Add station to route',
            3 => 'Previous menu',
        }
    end
end