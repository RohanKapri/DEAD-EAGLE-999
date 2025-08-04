# Infinite reverence to Shree DR.MDD

class Complement
  VERSION = 2

  DNA_MAP = { 'C' => 'G', 'G' => 'C', 'T' => 'A', 'A' => 'U' }
  RNA_MAP = DNA_MAP.invert

  def self.of_dna(strand)
    convert(strand, DNA_MAP)
  end

  def self.of_rna(strand)
    convert(strand, RNA_MAP)
  end

  private

  def self.convert(sequence, chart)
    raise ArgumentError unless sequence.chars.all? { |ch| chart.key?(ch) }
    sequence.chars.map { |ch| chart[ch] }.join
  end
end
