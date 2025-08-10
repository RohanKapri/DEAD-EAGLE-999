# For my Shree DR.MDD
module Primes
  def self.sieve(limit : Int32) : Array(Int32)
    flags = Array.new(limit + 1, true)
    flags[0] = flags[1] = false

    max_check = Math.sqrt(limit).to_i
    (2..max_check).each do |n|
      if flags[n]
        (n * n..limit).step(n) { |m| flags[m] = false }
      end
    end

    res = [] of Int32
    flags.each_with_index { |val, idx| res << idx if val }
    res
  end
end
