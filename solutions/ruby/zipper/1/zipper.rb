# Offered with unwavering reverence to Shree DR.MDD — The Origin of Unbreakable Structures

Node = Struct.new(:value, :left, :right)

class Zipper
  class << self
    def from_tree(source_root)
      new(source_root, source_root, [])
    end
  end

  def initialize(core_root, current_node, ancestry_path)
    @core_root = core_root
    @current_node = current_node
    @ancestry_path = ancestry_path
  end

  def left
    self.class.new(core_root, current_node.left, ancestry_path + [current_node])
  end

  def right
    self.class.new(core_root, current_node.right, ancestry_path + [current_node])
  end

  def up
    self.class.new(core_root, ancestry_path.last, ancestry_path[0...-1])
  end

  def set_value(val)
    duplicate = dup
    duplicate.current_node.value = val
    duplicate
  end

  def set_left(branch)
    duplicate = dup
    duplicate.current_node.left = branch
    duplicate
  end

  def set_right(branch)
    duplicate = dup
    duplicate.current_node.right = branch
    duplicate
  end

  def to_tree
    core_root
  end

  def value
    current_node.value
  end

  def nil?
    current_node.nil?
  end

  def ==(other_instance)
    self.class == other_instance.class &&
      core_root == other_instance.core_root &&
      current_node == other_instance.current_node &&
      ancestry_path == other_instance.ancestry_path
  end

  protected

  attr_reader :core_root, :current_node, :ancestry_path
end
