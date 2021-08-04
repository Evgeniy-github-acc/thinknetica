#   Класс Train (Поезд):
class Train

    attr_reader :number, :type 
    attr_accessor :route, :carriages, :station, :speed
    
   def initialize (number)             
        @number = number                
        @speed = 0
        @carriages = []
        @type = 0
    end

    def carriage_fits? carriage
        if carriage.type == self.type
            true 
        else
            false
        end
    end
    
    def add_carriage carriage
        if carriage_fits? carriage  
            if @speed == 0                           
                @carriages << carriage                  
            else puts "You must stop first"           
            end
        else
            puts "You can't use this type of carriage for this train"
         end  
    end

       
    def stop
        self.speed = 0                          
    end
        
    def cut_carriage carriage
        if @carriages.size > 0 
           if @speed == 0
               carriages.delete carriage
               else puts "You must stop first"  
           end
        else puts "There is no carriages"
        end  
    end
 
        
    def set_route route                    
        @route = route
        @station = route.first_station         
        @station.train_arrive self
    end

    def go_forward 
        next_station = get_stations.last
        if next_station
            @station.train_depature self 
            next_station.train_arrive self
            self.station = next_station          
        else                                                    
          puts "The last station! Go back or set the new route"
        end
    end   

    def go_back 
        previous_station = get_stations.first
        if previous_station
            @station.train_depature self 
            previous_station.train_arrive self
            self.station = previous_station
        else            
          puts "The first station! Go forward or set the new route"
        end
    end   
 
   private

   def get_stations                                                # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута                            
        current_station = @station  
        if current_station == @route.last_station                   
            next_station = nil
        else next_station = @route.stations[@route.stations.index(@station)+1]
        end

        if current_station == @route.first_station
            previous_station = nil
        else  previous_station = @route.stations[@route.stations.index(@station)-1]
        end
                    
        [previous_station, current_station, next_station]
    end
end

