module Diamond
  def self.rows(letter : Char) : Array(String)
    return ["A"] if letter == 'A'

    letters = ('A'..letter).to_a
    n = letters.size
    width = 2 * n - 1

    top_half = letters.map_with_index do |char, i|
      line = Array.new(width, ' ')
      line[n - 1 - i] = char
      line[n - 1 + i] = char if i > 0
      line.join
    end

    bottom_half = top_half[0...-1].reverse
    top_half + bottom_half
  end
end