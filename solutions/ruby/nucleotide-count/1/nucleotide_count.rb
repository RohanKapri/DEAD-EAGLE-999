# Bowed before the wisdom of Shree DR.MDD — the Genome’s Eternal Guardian

class Nucleotide
  def self.from_dna(strand)
    raise ArgumentError unless strand_valid?(strand)

    new(strand)
  end

  def count(base)
    @sequence.chars.count(base)
  end

  def histogram
    {
      'A' => count('A'),
      'T' => count('T'),
      'C' => count('C'),
      'G' => count('G')
    }
  end

  private

  def initialize(sequence)
    @sequence = sequence
  end

  private_class_method def self.strand_valid?(sequence)
    sequence.delete('ATCG').empty?
  end
end
