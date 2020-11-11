
require_relative "./codebreaker.rb"
require_relative "./codemaker.rb"
require_relative "./pegs.rb"
require_relative "./string_mod.rb"
require_relative "./board.rb"

class GameLogic

  def start_match
    @turns = 1
    actual_guess = @codebreaker.guess
    test_guess = actual_guess.clone

    while @turns < 13
      # binding.pry
      @play_board.board[@turns-1] = actual_guess
      return_feedback(actual_guess)

      if code_breaked?(@codemaker.code, test_guess)
        system ('clear')
        @play_board.draw_board
        winner_message(test_guess)
      else
        system ('clear')

        @play_board.draw_board
        break if @turns == 12
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
    system ('clear')
    "Welcome to Mastermind.\n
The goal is to crack a secret code in 12 turns.\n
There are four secret colors hidden, and for each guess you make,\n
a feedback is given showing you how close you are to solve the secret.\n
FEEDBACK RULES:\n 
BLACK = The place and color is right.\n 
WHITE = Only the color is right, place is wrong.\n "

  end

  def return_feedback(guess)
    tips = @codemaker.calculate_tips(guess)

    @play_board.board[@turns-1].push(">")
    @play_board.board[@turns-1].push(Pegs::DGRAY)
    @play_board.board[@turns-1].push("#{tips["place"]}")
    @play_board.board[@turns-1].push(Pegs::WHITE)
    @play_board.board[@turns-1].push("#{tips["color"]}")

  end

  def code_breaked?(code, guess)
    code == guess ? true : false
  end

  def winner_message(final_code)
    puts
    puts "Code Cracked!"
    print "SECRET > "
    for i in @codemaker.code
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
    print "The Code is: "
    print "#{i=0;while i < 4; print "#{@codemaker.code[i]}";i+=1;end}\n"

  end

  def exit_game
    answer = ""
    print "Thanks for playing.\nDo you want to play again?\n"
    print "(y/n)"
    answer = gets.chomp.upcase!

    until answer == "Y" || answer == "N"
      print "(y/n)"
      answer = gets.chomp.upcase!
    end
    answer == "Y" ? Match.new : exit
  end

end
