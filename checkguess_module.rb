module CheckGuess
  def valid_guess?(guess)
    # binding.pry
    guess = guess.to_s.upcase
    if ["B","G","R","E","O","M"].include?(guess)
      return true
    else
      puts "Not a valid guess. Insert a valid guess:"
      puts "(B)lue, (G)ray, (R)ed, Gr(E)en, Br(O)wn and (M)agenta:"
      return false
    end
  end
end
