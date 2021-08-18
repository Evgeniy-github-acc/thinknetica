# frozen_string_literal: true

class CargoTrain < Train
  def initialize(type)
    @type = :cargo
    super
  end
end
