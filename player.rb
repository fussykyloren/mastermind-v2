class Player
    attr_reader :player_name, :player_guess, :ai
    attr_accessor :key, :secret_code, :code_set

    def initialize(name, ai = 1)
        @player_name = name
        @code_set = (1..6).to_a.repeated_permutation(4).to_a
        @key = []
        @ai = ai
    end

    def produce_code
        @secret_code = []
        (0..3).each {|i| @secret_code[i] = (1 + rand(6))}
    end

    def compare_guess(answer, attempt)
        result = []
        duplicate_code = answer.dup
        duplicate_attempt = attempt.dup

        duplicate_code.each_with_index do |n, i|
            if n == duplicate_attempt[i]
                result << "B"
                duplicate_attempt[i] = 10
                duplicate_code[i] = 0
            end
        end

        duplicate_code.each_with_index do |n, i|
            duplicate_attempt.each_with_index do |m, j|
                if n == m
                    duplicate_code[i] = 10
                    n = 0
                    duplicate_attempt[j] = 10
                    result << "W"
                end
            end
        end

        result
    end

    def turn(guess)
        @key = []
        @key = compare_guess(self.secret_code, guess)
        @key.count("B").times {print "Black "}
        @key.count("W").times {print "White "}
        print "\nGuess: #{guess}\n"
    end

    def is_over?
        @key.count("guess") == 4 ? true : false
    end

    def generate_set(computer_key, guess)
        self.code_set.select!{|x| compare_guess(x, guess) == computer_key}
        self.code_set
    end

    def make_guess(guess_check)
        @player_guess = []
        until guess_check.include?(@player_guess)
            @player_guess = []
            puts "What's your guess? (Enter 4 digits from 1-6)"
            gets.chomp.each_char {|c| @player_guess << c.to_i}
        end
    end
end