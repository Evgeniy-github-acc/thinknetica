module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
     getter(attr)
     setter(attr)
     history_getter(attr)
    end  
  end

  def setter(attr)
    define_method("#{attr}=".to_sym) do |value|
      history = instance_variable_get("@#{attr}_history".to_sym)
      history = [] if history.nil?
      history << value
      instance_variable_set("@#{attr}".to_sym, value)
      instance_variable_set("@#{attr}_history".to_sym, history)
    end
  end

  def getter(attr)
    define_method(attr.to_sym){instance_variable_get("@#{attr}".to_sym)}
  end

  def history_getter(attr)
    define_method("#{attr}_history".to_sym){instance_variable_get("@#{attr}_history".to_sym)}
  end

  def strong_attr_setter(attr, type)
    define_method(attr.to_sym){instance_variable_get("@#{attr}".to_sym)}
    define_method("#{attr}=".to_sym) do |value|
      raise 'wrong type' unless value.is_a?(type)

      instance_variable_set("@#{attr}".to_sym, value)
    end
  end 
end