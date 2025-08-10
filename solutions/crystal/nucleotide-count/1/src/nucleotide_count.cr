module NucleotideCount
  def self.nucleotide_counts(nucleotides : String) : Hash(Char, Int32)
    counts = Hash(Char, Int32).new(0)

    nucleotides.each_char do |nucleotide|
      raise ArgumentError.new("Invalid DNA sequence") unless ['A', 'C', 'G', 'T'].includes?(nucleotide)
      counts[nucleotide] += 1
    end

    {'A', 'C', 'G', 'T'}.each do |nucleotide|
      counts[nucleotide] = counts[nucleotide]? || 0
    end

    counts
  end
end