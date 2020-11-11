require_relative "./pegs.rb"
require_relative "./checkguess_module.rb"

class CodeBreaker < Pegs
  include CheckGuess

  def initialize(name)
    @name = name
  end

  def guess
    guess = []
    print "Insert your guess. Choose 4 option between (B)lue, (G)ray, (R)ed, Gr(E)en, Br(O)wn and (M)agenta:"
    until guess.length == 4
      single_guess = gets.chomp.upcase!
      if valid_guess?(single_guess)
        single_guess = guess_to_peg(single_guess)
        # binding.pry
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
