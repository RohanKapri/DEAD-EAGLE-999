class Node
  property value : Int32
  property left : Node?
  property right : Node?

  def initialize(@value : Int32)
    @left = nil
    @right = nil
  end

  def insert(new_value : Int32)
    if new_value <= value
      if left
        left.as(Node).insert(new_value)
      else
        @left = Node.new(new_value)
      end
    else
      if right
        right.as(Node).insert(new_value)
      else
        @right = Node.new(new_value)
      end
    end
  end

  def sort : Array(Int32)
    left_sort = left ? left.as(Node).sort : [] of Int32
    right_sort = right ? right.as(Node).sort : [] of Int32
    left_sort + [value] + right_sort
  end
end