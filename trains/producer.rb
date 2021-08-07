module Producer
  def producer_name
    self.producer_name
  end

  def producer_name=(name)
    self.producer_name = name
  end

  attr_accessor :producer_name
end