class Carriage
    
    attr_reader :number, :type
   
    def initialize number
      @number = number
    end
  
    protected

    attr_writer :type

end