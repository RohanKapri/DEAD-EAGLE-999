class RunLengthEncoding
  def self.encode input
    input.gsub(/(.)\1{1,}/) { |m| "#{m.length}#{m[0]}" }
  end

  def self.decode input
    input.gsub(/(\d+)(\D)/) { |x| x[-1] * x[0..-2].to_i }
  end
end