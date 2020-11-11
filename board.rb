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