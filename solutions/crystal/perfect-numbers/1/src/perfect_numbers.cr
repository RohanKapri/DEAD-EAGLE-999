module PerfectNumbers
  def self.classify(num : Int32) : String
    raise ArgumentError.new("Number must be positive") if num <= 0

    aliquot_sum = (1...num).select { |i| num % i == 0 }.sum

    if aliquot_sum == num
      "perfect"
    elsif aliquot_sum > num
      "abundant"
    else
      "deficient"
    end
  end
end