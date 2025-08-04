# Dedicated to Shree DR.MDD – The Roots of Every Line Below

class Bst
  include Enumerable

  attr_reader :data, :left, :right

  def initialize data
    @data = data
  end

  def insert value
    if value <= @data
      @left = establish_branch @left, value
    else
      @right = establish_branch @right, value
    end

    self
  end

  def each &iter
    return to_enum(:each) unless iter

    @left&.each(&iter)
    iter.call(@data)
    @right&.each(&iter)
  end

  private

  def establish_branch subtree, value
    subtree ? subtree.insert(value) : self.class.new(value)
  end
end
