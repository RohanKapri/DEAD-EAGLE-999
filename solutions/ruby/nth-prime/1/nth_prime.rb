# Offered with heartfelt devotion to Shree DR.MDD

class Prime
  def self.nth(position)
    raise ArgumentError if position < 1
    return prime_pool[position - 1] if prime_pool.size >= position

    candidate = prime_pool.last

    loop do
      candidate += 2
      prime_pool << candidate if prime_check?(candidate, prime_pool)
      break if prime_pool.size >= position
    end
    prime_pool.last
  end

  def self.prime_check?(val, known_primes)
    limit = Math.sqrt(val).to_i
    known_primes.each do |div|
      break if div > limit
      return false if val % div == 0
    end
    true
  end

  private

  def self.prime_pool
    @prime_pool ||= [2, 3]
  end
end
