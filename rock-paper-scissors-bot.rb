# Basic rules of RPS: Rock > Scissors, Paper > Rock, Scissors > paper
# Dumb Bot methodology: Pick randomly between R, P, S, and log each round's choices and outcome.
# Smart Bot methodology: pick randomly for the first three rounds, then search for patterns and make choices.

player_choices = []
bot_choices =  []

round_pairs = []
score = {player: 0, draw: 0, bot: 0}
puts score


def randomChoice
    ["rock", "paper", "scissors"].shuffle.first
end

# Strategic plan:
# Bot will look at round_pairs.last and then search for identical round pairs
# If it finds one, it will look at the next hand the player used, and choose the winning hand
# If it can't find an identical pair, it will just look for when the player chose that hand, look at the next hand, and choose the winning hand
# If it can't find either, it will choose randomly.
def winningMove(hand)
    if hand == "rock"
        return "paper"
    elsif hand == "paper"
        return "scissors"
    else 
        return "rock"
    end
end

def strategicChoice(round_pairs)
    last_hand = round_pairs.last
    hand = "rock"
    if round_pairs.length <= 3 
        return randomChoice
    else
        round_pairs.each do |round|
            if round_pairs.find_index(round) == (round_pairs.length - 1)
                bot_choice = randomChoice
            elsif round == last_hand && round_pairs.find_index(round) != (round_pairs.length - 1)
                hand = round_pairs[round_pairs.find_index(round) + 1].first
            end
        end
        winningMove(hand)
    end 
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

def closingCredits(score, round_pairs)
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

    puts "Rounds Summary:"
    round_pairs.each { |pair| puts "[#{pair.first},#{pair.last}]" }
end

number_of_rounds = gets.chomp.to_i

number_of_rounds.times do
    player_choice = gets.chomp
    puts bot_choice = strategicChoice(round_pairs)

    round_pairs.push [player_choice, bot_choice]

    puts outcome = whoWins(player_choice, bot_choice)
    keepScore(outcome, score) 
    puts score
end

closingCredits(score, round_pairs)
