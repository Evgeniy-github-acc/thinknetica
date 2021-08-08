module InstanceCounter
  def self.included(object)
    object.extend ClassMethods
    object.include InstanceMethods
  end
  
  module ClassMethods
    def self.extended(object)
      class << object
        attr_accessor :counter
      end
    end

    def instances
      @counter
    end
  end  
  
  module InstanceMethods
  
  protected
    def register_instance
      self.class.counter ||= 0
      self.class.counter += 1
    end
  end
end