# frozen_string_literal: true

class CargoCarriage < Carriage
  attr_reader :max_volume
  attr_accessor :filled_volume

  def initialize(number, max_volume)
    @number = number
    @type = :cargo
    @max_volume = max_volume
    @filled_volume = 0
    validate!
  end

  def load(volume)
    raise "Carriage hasn't enough place" if filled_volume + volume >= max_volume

    filled_volume + volume
  end

  def free_volume
    max_volume - filled_volume
  end
end
