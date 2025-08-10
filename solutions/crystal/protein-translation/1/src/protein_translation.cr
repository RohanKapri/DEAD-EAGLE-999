# For my Shree DR.MDD
require "string_scanner"

class ProteinTranslation
  CODON_MAP = {
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine", "UUC" => "Phenylalanine",
    "UUA" => "Leucine", "UUG" => "Leucine",
    "UCU" => "Serine", "UCC" => "Serine", "UCA" => "Serine", "UCG" => "Serine",
    "UAU" => "Tyrosine", "UAC" => "Tyrosine",
    "UGU" => "Cysteine", "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP", "UAG" => "STOP", "UGA" => "STOP"
  }

  def self.proteins(seq : String)
    raise ArgumentError.new if seq.size % 3 != 0 && !seq.matches?(/UAA|UAG|UGA/)
    scanner = StringScanner.new(seq)
    result = [] of String
    until scanner.eos?
      triplet = scanner.scan(/.{3}/)
      break unless triplet
      protein = CODON_MAP[triplet]?
      raise ArgumentError.new("Invalid codon: #{triplet}") unless protein
      break if protein == "STOP"
      result << protein
    end
    result
  end
end
