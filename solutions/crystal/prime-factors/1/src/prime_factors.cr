module PrimeFactors
  def self.factors(value : Int64) : Array(Int32)
    factors = [] of Int32
    divisor = 2

    while value > 1
      while value % divisor == 0
        factors << divisor
        value /= divisor
      end
      divisor += 1
    end

    factors
  end
end