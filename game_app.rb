require 'pry-byebug'
require './logic_method'
require './players'
require 'colorize'

#Start Game

current_player = 0
@first_play = true

while play?

  while players_alive?

    ask_question(current_player)
    current_player = switch_players(current_player)

  end

  puts winner

  @first_play = false
  
end


