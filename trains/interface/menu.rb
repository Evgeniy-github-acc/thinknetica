# frozen_string_literal: true

class Items
  attr_reader :functions, :names

  def initialize
    @functions = {}
    @names = []
  end

  def functions=(functions)
    @functions = functions
    @functions.each_key { |key| @names << key }
  end

  def execute(function_name)
    proc = functions[function_name]
    proc.call
  end
end

class Menu
  attr_accessor :items

  def choice_exists?(choice)
    range = (0..items.names.length)
    regexp = /\A\d+\z/
    choice.match?(regexp) && range.include?(choice.to_i)
  end

  def choice_get
    loop do
      choice = gets.chomp
      return choice.to_i - 1 if choice_exists?(choice)

      puts 'Wrong choce'
    end
  end

  def navigate
    loop do
      items.names.each_with_index { |value, index| puts "#{index + 1} #{value}" }
      items.execute(items.names[choice_get])
    end
  end
end
