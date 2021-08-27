# frozen_string_literal: true

require_relative 'table'
require_relative 'deck'
require_relative 'hand'
require_relative 'game_functions'

include GameFunctions

puts 'Enter your name: '
name = gets.chomp
table = Table.new
dealer = Hand.new('Dealer', 100)
player = Hand.new(name, 100)
table.dealer = dealer
table.player = player

loop do
  if player.bank.zero?
    puts 'You have no money to continue'
    break
  end
  round_start(table)
  round(table)
  puts "#{player.bank} in your bank. Enter 'exit' to stop, or press Enter to continue"
  choise = gets.chomp
  break if choise == 'exit'
end
