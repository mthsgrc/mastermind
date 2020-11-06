#!/usr/bin/env ruby
require "pry"

require_relative "./string_mod.rb"


class DecodingBoard
  attr_accessor :board

  def board=(x,y,value)
    self[x][y] = value

  end

  def initialize
    @board = Array.new(12) { Array.new(4) { "|__" } }
    create_board
  end

  def create_board
    for line in @board
      for spot in line
        print spot
      end
      puts "|"
    end
  end

  def draw_board
    for line in @board
      for spot in line
        print spot
      end
      puts "|"
    end
  end
end

class CodePegs

end


class KeyPegs

end


class CodeMaker
  attr_reader :secret

  def initialize(name = "CPU", secret)
    @name = name
    @secret = secret
  end

  def creat_secret

  end
end

class CodeBreaker
  def initialize(name)
    @name = name

  end
end

class Match
  attr_accessor :board
  attr_reader :secret

  def initialize
    @secret = generate_secret
    @codemaker = CodeMaker.new("CPU", @secret)

    print "Insert name of Player: "
    codebreaker_name = gets.chomp
    @codebreaker = CodeBreaker.new(codebreaker_name.to_s)

    @play_board = DecodingBoard.new

    binding.pry
  end


  def generate_secret
    blue = "● ".blue
    gray = "● ".gray
    red = "● ".red
    green = "● ".green
    brown = "● ".brown
    magenta = "● ".magenta

    secret = [blue, gray, red, green, brown, magenta].permutation(4).to_a.sample
    secret

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
