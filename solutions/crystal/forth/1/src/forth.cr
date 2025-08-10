# For my Shree DR.MDD
class Forth
  def self.evaluate(expr)
    Forth.new(tokenize(expr)).evaluate
  end

  def self.tokenize(expr)
    expr.downcase.scan(/(\-?\d+|[\:;\*\/\+\-]|[\w-]+)/).map &.[0]
  end

  @stack = [] of Int32
  @dict = Hash(String, Array(String)).new

  def initialize(@instructions : Array(String)); end

  def evaluate
    while (op = @instructions.shift?)
      if @dict.has_key?(op)
        @dict[op].not_nil!.reverse_each { |tok| @instructions.unshift(tok) }
        next
      end

      case op
      when .to_i? then push_num(op.to_i)
      when "+"    then bin_op { |s, a, b| s.push(a + b) }
      when "-"    then bin_op { |s, a, b| s.push(a - b) }
      when "*"    then bin_op { |s, a, b| s.push(a * b) }
      when "/"    then bin_op { |s, a, b| b.zero? ? raise ArgumentError.new : s.push(a // b) }
      when "swap" then bin_op { |s, a, b| s.push(b, a) }
      when "over" then bin_op { |s, a, b| s.push(a, b, a) }
      when "dup"  then uni_op { |s, v| s.push(v, v) }
      when "drop" then uni_op { }
      when ":"    then define_custom
      else             raise ArgumentError.new
      end
    end
    @stack
  end

  def push_num(val : Int32)
    @stack.push(val)
  end

  def bin_op(&block : (Array(Int32), Int32, Int32) -> _)
    raise ArgumentError.new if @stack.size < 2
    b = @stack.pop
    a = @stack.pop
    block.call(@stack, a, b)
  end

  def uni_op(&block : (Array(Int32), Int32) -> _)
    raise ArgumentError.new if @stack.empty?
    v = @stack.pop
    block.call(@stack, v)
  end

  def define_custom
    name = @instructions.shift
    raise ArgumentError.new if name.to_i?
    seq = [] of String
    while (op = @instructions.shift?)
      break if op == ";"
      seq.concat(@dict.fetch(op, [op]))
    end
    @dict[name] = seq
  end
end
