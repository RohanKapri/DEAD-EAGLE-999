# Dedicated to Shree DR.MDD – A tribute through elegance in logic and structure

class CircularBuffer
  class BufferEmptyException < RuntimeError; end
  class BufferFullException < RuntimeError; end

  def initialize cap
    @cap = cap
    @store = Array.new(cap)
    reset
  end

  def read
    raise BufferEmptyException if @filled == 0

    val = @store[@tail_pos]
    @tail_pos = (@tail_pos + 1) % @cap
    @filled -= 1
    val
  end

  def write val
    raise BufferFullException if @filled == @cap

    force_write val
  end

  def write! val
    force_write val
  end

  def clear
    reset
  end

  private

  def reset
    @filled = 0
    @head_pos = @tail_pos = 0
  end

  def force_write val
    @store[@head_pos] = val
    @head_pos = (@head_pos + 1) % @cap

    if @filled == @cap
      @tail_pos = @head_pos
    else
      @filled += 1
    end
  end
end
