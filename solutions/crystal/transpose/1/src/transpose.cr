module Transpose
  def self.transpose(input : String) : String
    return "" if input.empty?

    lines = input.split("\n")
    max_width = lines.max_of(&.size)

    transposed_lines = Array.new(max_width) { Array.new(lines.size, '\0') }

    lines.each_with_index do |line, line_idx|
      line.each_char.with_index do |char, char_idx|
        transposed_lines[char_idx][line_idx] = char if char_idx < max_width
      end
    end

    transposed_lines
      .map(&.join.rstrip('\0').gsub('\0', ' '))
      .join('\n')
  end
end