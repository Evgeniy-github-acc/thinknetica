
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
       passenger = @trains_list.select{|train| train.type == :passenger}  #Может возвращать список поездов на станции по типу кол-во грузовых, пассажирских
       cargo = @trains_list.select{|train| train.type == :cargo}
       passenger.each {|i| puts i.number}
       cargo.each {|i| puts i.number}
    end
end