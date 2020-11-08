#!/usr/bin/env ruby
require "pry"

require_relative "./string_mod.rb"

module CheckGuess
  def valid_guess?(guess)
    # binding.pry
    guess.to_s.upcase!
    if ["B","G","R","E","O","M"].include?(guess)
      return true
    else
      puts "Not a valid guess. Insert a valid guess:"
      puts "(B)lue, (G)ray, (R)ed, Gr(E)en, Br(O)wn and (M)agenta:"
      return false
    end
  end
end


class DecodingBoard
  attr_accessor :board

  def initialize
    @board = Array.new(12) { Array.new(4) { "_" } }
    create_board
  end

  def board=(x,y,value)
    self[x][y] = value
  end

  def create_board
    for line in @board
      for holes in line
        print "|_#{holes}"
      end
      puts "|"
    end
  end

  def draw_board
    puts
    for line in @board
      for holes in line
        print "|#{holes}"
      end
      puts "|"
    end
  end

end

class Pegs
  BLUE = "● ".blue
  GRAY = "● ".gray
  RED = "● ".red
  GREEN = "● ".green
  BROWN = "● ".brown
  MAGENTA = "● ".magenta
  WHITE = "● ".white
  BLACK = "● ".black

  def guess_to_peg(guess)
    case guess
    when "B" then guess = BLUE
    when "G" then guess = GRAY
    when "R" then guess = RED
    when "E" then guess = GREEN
    when "O" then guess = BROWN
    when "M" then guess = MAGENTA
    end

    guess
  end
end

class CodePegs < Pegs


end


class KeyPegs < Pegs

end


class CodeMaker < Pegs
  include CheckGuess
  attr_reader :secret

  # again player or CPU
  def initialize(name = "CPU")
    @name = name
    @secret = generate_secret

  end

  def creat_secret
    secret = []
    until secret.length == 4
      secret << gets.chomp if valid_guess?(secret)
    end
    secret
  end

  def generate_secret
    secret = []
    while secret.length < 4
      secret << [BLUE, GRAY, RED, GREEN, BROWN, MAGENTA].sample
    end
    secret
  end

  # [2, 1, 3, 4]
  def feedback_check(guess) # [1, 2, 3, 4]
    tips = Hash.new(0)
    binding.pry

    i = 0
    while i < 4
      if guess.values_at(i) == secret.values_at(i)
        tips['place'] += 1

      elsif secret.include?(guess.values_at(i))
        tips['color'] += 1
      end

      i += 1
    end
    tips
  end

end

class CodeBreaker < Pegs
  include CheckGuess
  # attr_accessor :break_guess

  def initialize(name)
    @name = name
  end

  def guess
    guess = []
    print "Insert your guess. Choose 4 option between (B)lue, (G)ray, (R)ed, Gr(E)en, Br(O)wn and (M)agenta:"
    # binding.pry
    until guess.length == 4
      single_guess = gets.chomp
      if valid_guess?(single_guess)
        single_guess = guess_to_peg(single_guess)
        guess << single_guess
        for i in guess
          print "#{i} "
        end
        print "Insert another guess:" if guess.length < 4
      end
    end
    # @break_guess = guess
    guess
  end

end

class Match
  attr_accessor :play_board

  def initialize
    @codemaker = CodeMaker.new

    print "Insert name of Player: "
    codebreaker_name = gets.chomp
    @codebreaker = CodeBreaker.new(codebreaker_name.to_s)

    @play_board = DecodingBoard.new

    start_match
  end

  def start_match
    @turns = 1
    actual_guess = @codebreaker.guess

    while @turns < 3
      @play_board.board[@turns-1]= actual_guess

      binding.pry
      @codemaker.feedback_check(actual_guess)

      @play_board.draw_board

      if code_breaked?(@codemaker.secret, actual_guess)
        winner_message
      else
        puts
        puts "Guess does not match the secret. Try Again.\n"
        # puts
        actual_guess = @codebreaker.guess
        @turns += 1
      end
    end
    lost_message
  end

  def code_breaked?(secret, guess)
    secret == guess ? true : false
  end

  def winner_message
    binding.pry
    puts
    puts
    puts "Code Cracked!"
    print "SECRET > "
    for i in @codemaker.secret
      print "#{i} "
    end
    puts
    print "GUESS  > "
    for i in @codebreaker.break_guess
      print "#{i} "
    end
    puts
  end

  def lost_message
    puts
    puts "You couldn't crack the code."
  end
end



Match.new


# system "clear"
