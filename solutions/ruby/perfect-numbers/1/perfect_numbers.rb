class PerfectNumber
  def self.classify n
    raise RuntimeError unless n.positive?

    aliquot_sum = aliquot_sum n
    return 'deficient' if aliquot_sum < n
    return 'abundant' if aliquot_sum > n
    return 'perfect'
  end

  private_class_method def self.aliquot_sum n
    (1...n).filter { |x| n % x == 0 }.sum
  end
end