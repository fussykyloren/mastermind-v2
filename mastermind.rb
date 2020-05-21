require_relative "player.rb"

computer = Player.new("Computer")
puts "Do you want to be the codebreaker or codemaker?"
puts "1 -> Codebreaker"
puts "2 -> Codemaker"
choice = Integer(gets.chomp)
p choice.instance_of? Integer
while choice != 1 && choice != 2
    puts "Invalid input. Type 1 for codebreaker or 2 for codemaker."
    choice = Integer(gets.chomp)
end
if choice == 1
    user = Player.new("user", 0)
else
    user = Player.new("user")  
end

computer.produce_code
guess_count = 0
guess_check = (1..6).to_a.repeated_permutation(4).to_a
guess = []
while guess_count < 12
    guess_count += 1
    if user.ai == 1
        if guess_count == 1
            guess = [1,1,2,2]
        else
            user.code_set = user.generate_set(computer.key, guess)
            guess = user.code_set[0]
        end
    else
        user.make_guess(guess_check)
        guess = user.player_guess

    end

    computer.turn(guess)

    if computer.is_over?
        puts "#{user.player_name} won! It only took #{guess_count} turns!"
        a = 13
    end
end

if guess_count == 12
    puts "#{computer.player_name} won! The code was #{computer.secret_code}."
end