class CarrigePassenger < Carriage
    def initialize type
    super
    @type = :passenger
    end
end