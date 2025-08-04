class SumOfMultiples
  def initialize *ms
    @ms = ms
  end

  def to limit
    (1..limit - 1).to_a.filter do |n|
      @ms.any? { |m| n % m == 0 }
    end.sum
  end
end