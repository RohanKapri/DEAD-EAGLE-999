module SecretHandshake
  def self.commands(input : Number) : Array(String)
    actions = ["wink", "double blink", "close your eyes", "jump"]
    sequence = [] of String

    # Convert the input number to binary, ensuring it's at least 5 characters long
    binary = input.to_s(2).rjust(5, '0')

    # Reverse the binary string
    reversed_binary = binary.reverse

    # Convert the reversed binary string to an array of characters
    # and iterate over the first four bits (excluding the reverse action bit)
    reversed_binary.chars[0..3].each_with_index do |bit, index|
      # Add the action if the bit is '1'
      sequence << actions[index] if bit == '1'
    end

    # Reverse the sequence if the original leftmost bit (now the rightmost bit in reversed_binary) is '1'
    reversed_binary[4] == '1' ? sequence.reverse! : sequence
  end
end