module Say
  ONES = %w(zero one two three four five six seven eight nine)
  TEENS = %w(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  TENS = %w(twenty thirty forty fifty sixty seventy eighty ninety)

  def self.number(n : Int64) : String
    raise ArgumentError.new("Number is out of range") if n < 0 || n >= 1_000_000_000_000

    return ONES[n] if n < 10
    return TEENS[n - 10] if n < 20
    return TENS[n // 10 - 2] + (n % 10 == 0 ? "" : "-#{ONES[n % 10]}") if n < 100

    parts = [] of String
    scales = [{100, "hundred"}, {1_000, "thousand"}, {1_000_000, "million"}, {1_000_000_000, "billion"}]
    scales.reverse_each do |scale|
      limit, name = scale[0].to_i64, scale[1]
      if n >= limit
        parts << number((n / limit).to_i64) + " #{name}"
        n %= limit
      end
    end

    parts << number(n) unless n.zero?
    parts.join(" ")
  end
end