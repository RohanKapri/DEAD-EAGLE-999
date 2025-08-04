class ArmstrongNumbers
  private_class_method def self.digits n
    n.to_s.chars
  end

  private_class_method def self.sum n
    digits(n).map{ |c| c.to_i ** digits(n).length }.sum
  end

  def self.include? n
    sum(n) == n
  end
end