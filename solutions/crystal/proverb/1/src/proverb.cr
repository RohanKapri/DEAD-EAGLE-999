module Proverb
  def self.recite(input : Array(String)) : Array(String)
    output = [] of String
    input.each_with_index do |item, index|
      break if index >= input.size - 1  # Stop loop if the current element is the last one
      next_item = input[index + 1]
      output << "For want of a #{item} the #{next_item} was lost."
    end
    output << "And all for the want of a #{input.first}." unless input.empty?
    output
  end
end