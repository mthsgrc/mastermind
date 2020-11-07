#!/usr/bin/env ruby
require "pry"

require_relative "./string_mod.rb"


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
      for spot in line
        print "|_#{spot}"
      end
      puts "|"
    end
  end

  def draw_board
    for line in @board
      for spot in line
        print "| #{spot}"
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
end

class CodePegs < Pegs


end


class KeyPegs < Pegs

end


class CodeMaker < Pegs
  attr_reader :secret
  # again player or CPU
  # @secret = generate_secret
  # def initialize(name = "CPU", secret)
  def initialize(name = "CPU")
    @name = name
    @secret = generate_secret

  end

  def creat_secret

  end

  def generate_secret
    # blue = "● ".blue
    # gray = "● ".gray
    # red = "● ".red
    # green = "● ".green
    # brown = "● ".brown
    # magenta = "● ".magenta

    secret = []
    while secret.length < 4
      secret << [BLUE, GRAY, RED, GREEN, BROWN, MAGENTA].sample
    end

    secret
  end

end

class CodeBreaker
  attr_accessor :break_guess
  def initialize(name)
    @name = name
  end

  def guess
    guess = []
    print "Insert your guess. Choose 4 option between (B)lue, (G)ray, (R)ed, Gr(E)en, Br(O)wn and (M)agenta:"
    binding.pry
    until guess.length == 4
      single_guess = gets.chomp
      


    end
  end

  def valid_guess?(guess)
    guess.to_s.upcase!
    ["B","G","R","E","O","M"].include?(guess) ? true : false
  end
end

class Match
  attr_accessor :board

  def initialize
    @codemaker = CodeMaker.new

    print "Insert name of Player: "
    codebreaker_name = gets.chomp
    @codebreaker = CodeBreaker.new(codebreaker_name.to_s)

    @play_board = DecodingBoard.new

    match_starts
  end

  def match_starts
    until break_code(@codemaker.secret, @codebreaker.break_guess)
      @codebreaker.guess
    end
  end

  def break_code(secret, guess)
    secret == guess ? true : false
  end

end
Match.new


# system "clear"

# red
# blue
# yellow
# purple
# black
# white
