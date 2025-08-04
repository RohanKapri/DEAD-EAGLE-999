class PrimeFactors
  def self.of n
    prime_factors = []

    for i in 2.. do
      while n % i == 0 do
        prime_factors.push i
        n /= i
      end

      return prime_factors if n == 1
    end
  end
end