class Hamming
  def self.compute(strand1, strand2)
    raise ArgumentError if strand1.length != strand2.length

    strand1.length.times.count do |strand_index|
      strand1[strand_index] != strand2[strand_index]
    end
  end
end

module BookKeeping
  VERSION = 3
end