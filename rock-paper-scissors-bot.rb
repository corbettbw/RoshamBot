# Basic rules of RPS: Rock > Scissors, Paper > Rock, Scissors > paper
# Dumb Bot methodology: Pick randomly between R, P, S, and log each round's choices and outcome.
# Smart Bot methodology: pick randomly for the first three rounds, then search for patterns and make choices.

player_choices = []
bot_choices =  []
score = {player: 0, draw: 0, bot: 0}
puts score


def randomChoice
    ["rock", "paper", "scissors"].shuffle.first
end

def whoWins(player_choice, bot_choice)
    if player_choice == bot_choice
        return "DRAW"
    else 
        case player_choice
        when "rock"
            case bot_choice
            when "paper"
                return "Player LOSES"
            when "scissors"
                return "Player WINS"
            end
        when "paper"
            case bot_choice
            when "rock"
                return "Player WINS"
            when "scissors"
                return "Player LOSES"
            end
        when "scissors"
            case bot_choice
            when "rock"
                return "Player LOSES"
            when "paper"
                return "Player WINS"
            end
        end
    end
end

def keepScore(outcome, score)
    if outcome == "Player WINS"
        score[:player] += 1
    elsif outcome == "Player LOSES"
        score[:bot] += 1
    elsif outcome == "DRAW"
        score[:draw] += 1
    end
end



number_of_rounds = gets.chomp.to_i

number_of_rounds.times do
    player_choices.push player_choice = gets.chomp
    puts bot_choices.push bot_choice = randomChoice

    puts outcome = whoWins(player_choice, bot_choice)
    keepScore(outcome, score) 
    puts score
end

3.times {puts ""}

puts "Final Score: #{score}"
if score[:player] > score[:bot]
    puts "Player WINS THE GAME"
elsif score[:player] < score[:bot]
    puts "Player LOSES THE GAME"
else 
    puts "It's a DRAW"
end

3.times {puts ""}
