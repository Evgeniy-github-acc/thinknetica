# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(type)
    @type = :passenger
    super
  end
end
