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