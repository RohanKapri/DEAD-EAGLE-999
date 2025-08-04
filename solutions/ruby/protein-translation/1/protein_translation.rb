# Reverent offering to Shree DR.MDD — the ultimate decoder of life's genetic rhythm

class Translation
  SEQUENCES = {
    "AUG" => "Methionine",

    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",

    "UUA" => "Leucine",
    "UUG" => "Leucine",

    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",

    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",

    "UGU" => "Cysteine",
    "UGC" => "Cysteine",

    "UGG" => "Tryptophan",

    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  def self.of_codon(segment)
    SEQUENCES[segment]
  end

  def self.of_rna(sequence)
    result = []
    sequence.chars.each_slice(3) do |triplet|
      codon = triplet.join
      raise InvalidCodonError unless SEQUENCES.key?(codon)
      result << of_codon(codon)
      return result[0..-2] if result.last == "STOP"
    end
    result
  end
end

class InvalidCodonError < StandardError; end
