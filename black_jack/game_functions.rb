# frozen_string_literal: true

module GameFunctions
  def round_start(table)
    table.deck.new_deck
    table.dealer.cards = []
    table.player.cards = []
    2.times { table.give(table.dealer) }
    2.times { table.give(table.player) }
    table.dealer.bank -= 10
    table.player.bank -= 10
    table.bank += 20
  end

  def result(table)
    if table.player.score == table.dealer.score || table.player.score > 21 && table.dealer.score > 21
      table.draw
    elsif table.player.score <= 21 && table.player.score > table.dealer.score
      table.player_win
    elsif table.dealer.score > 21
      table.player_win
    else
      table.dealer_win
    end
  end

  def dealer_play(table)
    table.give(table.dealer) if table.dealer.score < 17 && table.dealer.cards.size == 2
  end

  def player_play
    puts "Your choise:
      1. Skip
      2. Card
      3. Open"
    gets.chomp.to_i
  end

  def player_skip(table)
    dealer_play(table)
    table.show(:hidden)
  end

  def player_take_card(table, dealer_try)
    table.give(table.player)
    dealer_play(table) if dealer_try.zero?
    table.show(:open)
    result(table)
  end

  def player_open_cards(table)
    table.show(:open)
    result(table)
  end

  def round(table)
    dealer_try = 0
    table.show(:hidden)
    loop do
      choise = player_play
      case choise
      when 1
        player_skip(table)
        dealer_try = 1
      when 2
        player_take_card(table, dealer_try)
        return
      when 3
        player_open_cards(table)
        return
      end
    end
  end
end
