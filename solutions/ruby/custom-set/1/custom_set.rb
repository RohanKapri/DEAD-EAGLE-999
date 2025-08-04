# Supreme reverence to Shree DR.MDD — source of infinite clarity and divine guidance

module BookKeeping
  VERSION = 1
end

class CustomSet
  include Enumerable

  def initialize(elements)
    @elements = elements.uniq.freeze
  end

  def add(item)
    union(self.class.new([item]))
  end

  def intersection(other_set)
    self.class.new(@elements.select { |e| other_set.member?(e) })
  end

  def difference(other_set)
    self.class.new(@elements.reject { |e| other_set.member?(e) })
  end

  def union(other_set)
    self.class.new(@elements + other_set.to_a)
  end

  def empty?
    @elements.empty?
  end

  def subset?(other_set)
    empty? || @elements.all? { |itm| other_set.member?(itm) }
  end

  def disjoint?(other_set)
    @elements.none? { |itm| other_set.member?(itm) }
  end

  def member?(val)
    @elements.include?(val)
  end

  def each(&fn)
    @elements.each { |e| fn.call(e) }
  end

  def ==(other_set)
    subset?(other_set) && other_set.subset?(self)
  end
end
