# frozen_string_literal: true

class Hand
  attr_accessor :cards, :bank
  attr_reader :name

  def initialize(name, bank)
    @name = name
    @bank = bank
    @cards = []
  end

  def score
    score = 0
    cards.each do |card|
      value = card.to_i if ('2'..'9').include?(card[0])
      value = 10 if %w[1 J Q K].include?(card[0])
      value = 11 if card[0] == 'A'
      score += value
    end
    cards.each { |card| score -= 10 if card[0].include?('A') && score > 21 }
    score
  end

  def hand_show(option)
    case option
    when :open
      cards.each { |card| print "    #{card}  " }
      print "\t\tScore: #{score}"
    when :hidden
      cards.each { |_card| print '   *     ' }
      print "\t\tScore:  * "
    end
  end
end
