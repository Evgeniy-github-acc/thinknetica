class CarrigeCargo < Carriage
    def initialize type
        super
        @type = :cargo
    end
end