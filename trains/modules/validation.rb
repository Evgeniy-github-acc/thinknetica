module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(attribute, validation_type, param = nil)
      validations << { attribute: attribute, validation_type: validation_type, param: param }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    def validate!
      return if self.class.validations.nil?

      self.class.validations.each do |validation|
        send("#{validation[:validation_type]}", validation[:attribute], validation[:param])
      end
    end
    
    def value(attribute)
      instance_variable_get("@#{attribute}".to_sym)
    end

    def attr_presence(attribute)
      raise "Value is empty" if value(attribute).nil?
    end

    def attr_format(attribute, param)
      raise "Wrong format" unless value(attribute).match?(param)
    end

    def attr_type(attribute, type)
      raise "Wrong type" unless value(attribute).is_a?(type)
    end
  end
end  