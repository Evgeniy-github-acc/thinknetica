
# Класс Station (Станция):

class Station
    attr_reader :trains_list, :name

    def initialize (name)
        @name = name        # Имеет название, которое указывается при ее создании
        @trains_list = []   # Может возвращать список всех поездов на станции, находящиеся в текущий момент
    end   
    
    def train_arrive (train)
        @trains_list << train   #Может принимать поезда (по одному за раз)
    end

    def trains_on_station   
        @trains_list.each{|train| puts train.number} 
    end    

    def train_depature (train, station)    #Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
        @trains_list.delete train
        train.station = station
    end    

    def trains_types
       passenger = @trains_list.select{|train| train.type == 1}  #Может возвращать список поездов на станции по типу кол-во грузовых, пассажирских
       freight = @trains_list.select{|train| train.type == 2}
       passenger.each {|i| puts i.number}
       freight.each {|i| puts i.number}
    end
end


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

# Класс Route (Маршрут):

class Route
    attr_reader :first_station, :last_station, :stations
    
    def initialize first_station, last_station #Имеет начальную и конечную станцию, а также список промежуточных станций. 
        @first_station = first_station         #Начальная и конечная станции указываютсся при создании маршрута, 
        @last_station = last_station           # а промежуточные могут добавляться между ними.
        @stations = [@first_station, @last_station]
    end
    
    def add_station (station)         #Может добавлять промежуточную станцию в список
        @stations.insert(-2, station) 
    end

    def delete_station (station)  # Может удалять промежуточную станцию из списка
        @stations.delete station
    end

    def show_stations
        @stations.each{|station| puts station.name} #Может выводить список всех станций по-порядку от начальной до конечной
    end    
end