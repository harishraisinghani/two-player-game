require 'pry-byebug'
require './players'
require 'colorize'

#Method to setup players 1 and 2
def setup

  puts "Enter Player 1's name:"
  @player_1 = Players.new(gets.strip)

  puts "Enter Player 2's name:"
  @player_2 = Players.new(gets.strip)
  @current_player = @player_1
end

def players_alive?
  @player_1.lives != 0 && @player_2.lives != 0 
end

def generate_question
  @rand_arr = []
  2.times do
    @rand_arr << rand(1..20)
  end
  
  operation = rand(1..3)
  case operation
  when 1 then @rand_arr << '+'
  when 2 then @rand_arr << '-'
  when 3 then @rand_arr << '*'
  end

  "#{@rand_arr[0]} #{@rand_arr[2]} #{@rand_arr[1]}"
end

def ask_question(player)
  puts "#{player.name}: What is #{generate_question}?"
  input = gets.strip.to_i

  if verify_answer?(input)
    player.gain_point
  else
    player.lose_life
  end
end

def verify_answer?(input)
  @rand_arr[0].send(@rand_arr[2],@rand_arr[1]) == input
end

def switch_players(player) 
  if player == @player_1
    player = @player_2
  else
    player = @player_1
  end
end

def winner
  if @player_1.lives == 0
    puts "#{@player_2.name} Wins!".green
  else
    puts "#{@player_1.name} Wins!".green
  end
  puts "#{@player_1.name}'s score is #{@player_1.score} and remaining lives is #{@player_1.lives}"
  puts "#{@player_2.name}'s score is #{@player_2.score} and remaining lives is #{@player_2.lives}"
end

def play?
  if @first_play == true
    true
  else
    puts "Do you want to play again? Y/N"
    input = gets.strip
    if input == "Y"
      @player_1.lives = 3
      @player_2.lives = 3
      @player_1.score = 0
      @player_2.score = 0
      true
    else
      puts "Thanks for playing"
      false
    end
  end
end


#Game initialization
setup
@first_play = true

while play?
  while players_alive?
    ask_question(@current_player)
    @current_player = switch_players(@current_player)
  end
  puts winner
  @first_play = false
end


