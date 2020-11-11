
require_relative "./pegs.rb"
require_relative "./checkguess_module.rb"

class CodeMaker < Pegs
  include CheckGuess
  attr_reader :code

  # again player or CPU
  def initialize(name = "CPU")

    @name = name
    @name == "CPU" ? @code = generate_code : @code = create_code

  end

  def create_code
    code = []
    until code.length == 4
      print "Insert your secret code. Choose 4 color from the following:\n(B)lue, (G)ray, (R)ed, Gr(E)en, Br(O)wn and (M)agenta:"
      # binding.pry
      single_code = gets.chomp.upcase!

      if valid_guess?(single_code)
        single_code = guess_to_peg(single_code)
        puts "You selected the color: #{single_code}.\n"
        code <<  single_code
      end
    end
    puts

    print_code(code)

    self.create_code if accept_code?(code) == false
    system("clear")

    code
  end

  def generate_code
    code = []
    while code.length < 4
      code << [BLUE, GRAY, RED, GREEN, BROWN, MAGENTA].sample
    end
    code
  end

  def print_code(code)
    i = 0
    # binding.pry
    print "You've created the following secret code: "
    while i < code.length
      print "#{code[i]} "
      i += 1
    end
    print "\n"
  end

  def accept_code?(code)
    print "Do you accept the created code? 'Y' for accept, 'N' to create another.\n"
    answer = gets.chomp.upcase

    until answer == "Y" || answer == "N"
      print "Choose a valid option. Accept created code? (Y/N)"
      answer = gets.chomp.upcase
    end

    answer == "Y" ? true : false
  end

  def calculate_tips(guess)

    tips = Hash.new(0)
    compare_guess = guess.clone
    temp_code = code.clone

    i = 0
    while i < 4
      if compare_guess.at(i) == code.at(i)
        tips['place'] += 1
        temp_code[i] = nil
        compare_guess[i] = "_"
      end
      i += 1
    end

    j = 0
    while j < 4
      if temp_code.include?(compare_guess.at(j))
        tips['color'] += 1
        idx = temp_code.index(compare_guess.at(j))
        temp_code[idx] = nil
      end
      j += 1
    end

    # binding.pry
    tips
  end

end