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