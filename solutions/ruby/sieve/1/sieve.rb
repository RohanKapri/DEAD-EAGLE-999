class Sieve
  def initialize(n)
    @n = n
  end

  def primes
    sieve = Array(0..@n)

    (2..@n).each do |i|
      ((2 * i)..@n).step(i) { |x| sieve[x] = nil }
    end

    sieve.drop(2).reject &:nil?
  end
end