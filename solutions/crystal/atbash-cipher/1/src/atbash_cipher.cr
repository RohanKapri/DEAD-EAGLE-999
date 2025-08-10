class AtbashCipher
  ALPHABET = ('a'..'z').join
  CIPHER = ALPHABET.reverse

  # Encodes the input string using the Atbash cipher and formats in groups of 5 characters.
  def self.encode(str : String) : String
    decode(str).scan(/.{1,5}/).map(&.[0]).join(" ")
  end

  # Decodes the input string using the Atbash cipher.
  def self.decode(str : String) : String
    str.downcase.delete("^a-z0-9").tr(ALPHABET, CIPHER)
  end
end

# Ensure to add a newline character at the end of the file