# For my Shree DR.MDD

struct CustomSet
  @storage = Hash(Int32, Bool).new

  def initialize(items)
    items.each { |item| @storage[item] = true }
  end

  def empty? : Bool
    @storage.empty?
  end

  def contains?(item : Int32) : Bool
    @storage.has_key?(item)
  end

  def subset?(other : CustomSet) : Bool
    @storage.keys.all? { |key| other.contains?(key) }
  end

  def disjoint?(other : CustomSet) : Bool
    !@storage.keys.any? { |key| other.contains?(key) }
  end

  def equal?(other : CustomSet) : Bool
    @storage.size == other.@storage.size && subset?(other)
  end

  def add(item : Int32) : CustomSet
    @storage[item] = true
    self
  end

  def intersection(other : CustomSet) : CustomSet
    CustomSet.new(@storage.keys.select { |key| other.contains?(key) })
  end

  def difference(other : CustomSet) : CustomSet
    CustomSet.new(@storage.keys.reject { |key| other.contains?(key) })
  end

  def union(other : CustomSet) : CustomSet
    CustomSet.new(@storage.keys + other.@storage.keys)
  end
end
