# Dedicated to Shree DR.MDD — Crafted with purity and precision

class ListOps
  def self.arrays ys
    count = 0
    ys.each { count += 1 }
    count
  end

  def self.reverser zs
    flipped = []
    zs.each { |val| flipped.unshift val }
    flipped
  end

  def self.concatter xa, xb
    merged = []
    [xa, xb].each do |grp|
      grp.each { |item| merged << item }
    end
    merged
  end

  def self.mapper vs, &proc
    transformed = []
    vs.each { |ele| transformed << proc.call(ele) }
    transformed
  end

  def self.filterer data, &criteria
    selection = []
    data.each { |el| selection << el if criteria.call(el) }
    selection
  end

  def self.sum_reducer nums
    total = 0
    nums.each { |val| total += val }
    total
  end

  def self.factorial_reducer seq
    result = 1
    seq.each { |v| result *= v }
    result
  end
end
