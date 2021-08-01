#   Класс Train (Поезд):
class Train
    attr_reader :number, :size, :type
    attr_accessor :speed, :route

    def initialize (number, type, size) # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, 
        @number = number                # эти данные указываются при создании экземпляра класса
        @type = type
        @size = size
        @speed = 0
    end
    

    def stop
        self.speed = 0    # Может тормозить (сбрасывать скорость до нуля)
    end
    
    def add_carriage 
      if @speed == 0                   #  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, 
        @size += 1                     #  метод просто увеличивает или уменьшает количество вагонов). 
      else puts "You must stop first"  # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
      end  
    end    
    
    def cut_carriage
        if size > 0 
           if @speed == 0
               @size -= 1
               else puts "You must stop first"  
           end
        else "There is no carriages"
        end  
      end

      
    def set_route(route)                    # Может принимать маршрут следования (объект класса Route) 
        @route = route
        @station = route.first_station         # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
        @station.train_arrive (self) 
    end

    def go_forward 
        next_station = get_stations.last
        if next_station
            @station.train_depature self, next_station          # Может перемещаться между станциями, указанными в маршруте.
        else                                                    # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
          puts "The last station! Go back or set the new route"
        end
    end   

    def go_back
        previous_station = get_stations.first
        if previous_station
            @station.train_depature self, previous_station
        else            
          puts "The first station! Go forward or set the new route"
        end
    end   

    def get_stations                                                # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута                            
        current_station = @station  
        if current_station == route.last_station
            next_station = nil
        else next_station = @route.stations[@route.stations.index(@station)+1]
        end

        if current_station == route.first_station
            previous_station = nil
        else  previous_station = @route.stations[@route.stations.index(@station)-1]
        end
                    
        [previous_station, current_station, next_station]
    end
end

