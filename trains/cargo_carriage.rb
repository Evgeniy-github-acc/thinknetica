class CargoCarrige < Carriage
    def initialize(type)
      @type = :cargo    
      super
    end
end