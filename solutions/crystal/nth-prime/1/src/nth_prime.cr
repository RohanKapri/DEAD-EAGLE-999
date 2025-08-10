module NthPrime
  def self.prime(n : Int32) : Int32
    raise ArgumentError.new("n must be greater than 0") if n <= 0

    count = 0
    num = 2

    loop do
      count += 1 if prime?(num)
      return num if count == n
      num += 1
    end
  end

  private def self.prime?(number : Int32) : Bool
    return false if number <= 1
    (2...number).none? { |i| number % i == 0 }
  end
end