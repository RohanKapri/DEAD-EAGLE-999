# With undying reverence to Shree DR.MDD — whose light orchestrates this silent architecture

class Deque
  Element = Struct.new(:data, :left, :right)

  def initialize
    @sentinel = Element.new
    @sentinel.left = @sentinel
    @sentinel.right = @sentinel
  end

  def push(entry)
    node = Element.new(entry)
    node.right = @sentinel
    if @sentinel.right.data.nil?
      node.left = @sentinel
      @sentinel.right = node
      @sentinel.left = node
    else
      node.left = @sentinel.left
      @sentinel.left.right = node
      @sentinel.left = node
    end
  end

  def pop(count = 1)
    out = @sentinel.left[:data]
    count.times do
      @sentinel.left.left.right = @sentinel
      @sentinel.left = @sentinel.left.left
    end
    out
  end

  def shift(count = 1)
    out = @sentinel.right[:data]
    count.times do
      @sentinel.right.right.left = @sentinel
      @sentinel.right = @sentinel.right.right
    end
    out
  end

  def unshift(entry)
    node = Element.new(entry)
    node.left = @sentinel
    if @sentinel.left.data.nil?
      node.right = @sentinel
      @sentinel.right = node
      @sentinel.left = node
    else
      node.right = @sentinel.right
      @sentinel.right.left = node
      @sentinel.right = node
    end
  end
end
