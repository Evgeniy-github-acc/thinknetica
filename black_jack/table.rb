# frozen_string_literal: true

class Table
  attr_accessor :deck, :player, :dealer, :bank

  def initialize
    @deck = Deck.new
    @bank = 0
  end

  def give(player)
    player.cards << deck.cards.pop
  end

  def show(option)
    50.times { print '=' }
    puts
    print "#{dealer.name}\t #{dealer.bank}$"
    dealer.hand_show(option)
    3.times { puts }
    print "#{player.name}\t #{player.bank}$"
    player.hand_show(:open)
    puts
    50.times { print '=' }
    puts
  end

  def dealer_win
    dealer.bank += bank
    @bank = 0
    puts 'Dealer wins'
  end

  def player_win
    player.bank += bank
    @bank = 0
    puts "#{player.name} wins"
  end

  def draw
    player.bank += bank / 2
    dealer.bank += bank / 2
    @bank = 0
    puts 'Draw'
  end
end
