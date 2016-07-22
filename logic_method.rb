#Method to generate game questions
def generate_question
  @rand_arr = []
  2.times do
    @rand_arr << rand(1..20)
  end
  "#{@rand_arr[0]} + #{@rand_arr[1]}"
end


#Method to verify user answer
def verify_answer?(input)
  @rand_arr[0] + @rand_arr[1] == input
end


#Method to score a point
def score(player)
  @players[player][:score] += 1
end


#Method to lose a life
def lose_life(player)
  @players[player][:lives] -= 1
end

#Method to check if players alive
def players_alive?
  @players[0][:lives] != 0 && @players[1][:lives] != 0 
end

#Method to ask question to current player
def ask_question(player)

  puts "Player #{player+1}: What is #{generate_question}?"
  input = gets.strip.to_i

  if verify_answer?(input)
    score(player)
  else
    lose_life(player)
  end
end

#Method to switch players
def switch_players(player) 
  if player == 0
    player = 1
  else
    player = 0
  end
end

#Winning Message
def winner
  if @players[0][:lives] == 0
    puts "Player 2 Wins!".green
  else
    puts "Player 1 Wins!".green
  end
  puts @players
end

def play?
  # (condition) ? value_if_true : value_if_false
  puts "Do you want to play#{ @first_play ? "" : " again"}? Y/N"
  input = gets.strip
  if input == "Y"
    @players[0][:lives] = 3
    @players[1][:lives] = 3
    true
  else
    puts "Thanks for playing"
    false
  end
end







