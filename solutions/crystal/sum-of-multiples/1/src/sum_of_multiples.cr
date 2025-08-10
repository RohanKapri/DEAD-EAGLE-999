module SumOfMultiples
  def self.sum(factors : Array(Int32), limit : Int32) : Int32
    multiples = Set(Int32).new

    factors.each do |factor|
      next if factor == 0

      multiple = factor
      while multiple < limit
        multiples.add(multiple)
        multiple += factor
      end
    end

    multiples.sum
  end
end