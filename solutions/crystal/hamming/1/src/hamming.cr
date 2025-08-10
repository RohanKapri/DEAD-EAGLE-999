class Hamming
  def self.distance(base : String, diff : String)
    raise ArgumentError.new("Strands are not of equal length") unless base.size == diff.size
    base.each_char.zip(diff.each_char).count { |(b, d)| b != d }
  end
end