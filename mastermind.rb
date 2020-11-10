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
  DGRAY = "● ".darkgray


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

class CodeMaker < Pegs
  include CheckGuess
  attr_reader :secret

  # again player or CPU
  def initialize(name = "CPU")

    @name = name
    @name == "CPU" ? @secret = generate_secret : @secret = create_secret

  end

  def create_secret
    secret = []
    until secret.length == 4
      print "Insert your code secret: "
      single_code = gets.chomp

      if valid_guess?(single_code)
        single_code = single_code.guess_to_peg
        secret <<  single_code
      end
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


  def calculate_tips(guess)

    tips = Hash.new(0)
    compare_guess = guess.clone
    temp_secret = secret.clone

    i = 0
    while i < 4
      if compare_guess.at(i) == secret.at(i)
        tips['place'] += 1
        temp_secret[i] = nil
        compare_guess[i] = "_"
      end
      i += 1
    end

    j = 0
    while j < 4
      if temp_secret.include?(compare_guess.at(j))
        tips['color'] += 1
        idx = temp_secret.index(compare_guess.at(j))
        temp_secret[idx] = nil
      end
      j += 1
    end

    # binding.pry
    tips
  end

end

class CodeBreaker < Pegs
  include CheckGuess

  def initialize(name)
    @name = name
  end

  def guess
    guess = []
    print "Insert your guess. Choose 4 option between (B)lue, (G)ray, (R)ed, Gr(E)en, Br(O)wn and (M)agenta:"
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
    guess
  end

end

class Match
  attr_accessor :play_board
  def initialize
    print welcome_message

    puts
    print "To start, insert name of CodeBreaker: "
    codebreaker_name = gets.chomp
    @codebreaker = CodeBreaker.new(codebreaker_name.to_s)
    puts
    print "Who will create the secret code:\n"
    codemaker_name = ""
    until codemaker_name == "C" || codemaker_name == "P"
      print "(C)omputer o another (P)layer?\n"
      codemaker_name = gets.chomp.upcase!
    end

    if codemaker_name == "P"
      print "Insert name of CodeMaker Player: "
      codemaker_name = gets.chomp
    end

    codemaker_name == "C" ? @codemaker = CodeMaker.new : @codemaker = CodeMaker.new(codemaker_name)

    @play_board = DecodingBoard.new

    start_match
  end

  def start_match
    @turns = 1
    actual_guess = @codebreaker.guess
    test_guess = actual_guess.clone

    while @turns < 13
      # binding.pry
      @play_board.board[@turns-1] = actual_guess
      return_feedback(actual_guess)

      if code_breaked?(@codemaker.secret, test_guess)
        @play_board.draw_board
        winner_message(test_guess)
      else

        @play_board.draw_board
        break if @turns == 5
        puts
        puts "Guess does not match the secret. Try Again.\n"
        # puts
        actual_guess = @codebreaker.guess
        test_guess = actual_guess.clone
        @turns += 1
        # puts "TURN NUMBER >>>> #{@turns}"
      end
    end
    lost_message
    exit_game
  end

  def welcome_message
    "Welcome to Mastermind.\n
You will have to crack a secret code to win.\n
There are four secret colors hidden, and for each guess you make\n
a feedback is given showing how close you are from the code.\n
Guess between Blue, Brown, Gray, Green, Magenta and Red."

  end

  def return_feedback(guess)
    tips = @codemaker.calculate_tips(guess)

    @play_board.board[@turns-1].push(">")
    @play_board.board[@turns-1].push(Pegs::DGRAY)
    @play_board.board[@turns-1].push("#{tips["place"]}")
    @play_board.board[@turns-1].push(Pegs::WHITE)
    @play_board.board[@turns-1].push("#{tips["color"]}")

    # @play_board.draw_board
  end

  def code_breaked?(secret, guess)
    secret == guess ? true : false
  end

  def winner_message(final_code)
    puts
    puts "Code Cracked!"
    print "SECRET > "
    for i in @codemaker.secret
      print "#{i} "
    end
    puts
    print "GUESS  > "
    for i in final_code
      print "#{i} "
    end
    puts
    exit_game
  end

  def lost_message
    puts
    puts "You couldn't crack the code."
    # binding.pry
    print "The Code is: "
    print "#{i=0;while i < 4; print "#{@codemaker.secret[i]}";i+=1;end}\n"

  end

  def exit_game
    answer = ""
    print "Thanks for playing.\nDo you want to play again?\n"
    until answer == "Y" || answer == "N"
      print "(y/n)"
      answer = gets.chomp.upcase!
    end
    answer == "Y" ? Match.new : exit
  end
end

Match.new
