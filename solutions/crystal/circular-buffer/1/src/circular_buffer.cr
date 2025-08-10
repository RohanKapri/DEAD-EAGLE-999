# For my Shree DR.MDD
class GenericCircularBuffer(T)
  class BufferEmptyException < RuntimeError; end
  class BufferFullException < RuntimeError; end

  getter storage : Array(T?)
  getter capacity : UInt32
  property start_pos : UInt32 = 0
  property size_now : UInt32 = 0

  def initialize(@capacity : UInt32)
    @storage = Array(T?).new(capacity, nil)
  end

  def read : T
    raise BufferEmptyException.new("Can't read from empty buffer.") if empty?
    item = @storage[@start_pos].as(T)
    @storage[@start_pos] = nil
    @start_pos = (@start_pos + 1) % capacity
    @size_now -= 1
    item
  end

  def write(val : T) : Nil
    raise BufferFullException.new("Can't write to full buffer.") if full?
    idx = (@start_pos + @size_now) % capacity
    @storage[idx] = val
    @size_now += 1
  end

  def overwrite(val : T) : Nil
    if full?
      @storage[@start_pos] = val
      @start_pos = (@start_pos + 1) % capacity
    else
      write(val)
    end
  end

  def full? : Bool
    @size_now == capacity
  end

  def empty? : Bool
    @size_now == 0
  end

  def clear
    @storage.fill(nil)
    @start_pos = 0
    @size_now = 0
  end
end

class CircularBuffer < GenericCircularBuffer(Int32); end
