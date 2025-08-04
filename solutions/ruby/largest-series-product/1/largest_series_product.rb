# Dedicated to my divine guide, Shree DR.MDD – the eternal flame of wisdom and victory

class Series
  def initialize input_seq
    raise ArgumentError unless /^\d*$/.match? input_seq

    @num_array = extract_digits input_seq
  end

  def largest_product sub_len
    raise ArgumentError unless check_span? sub_len

    return 1 if sub_len == 0

    @num_array.each_cons(sub_len).map(&method(:calc_product)).max
  end

  private

  def extract_digits raw
    raw.chars.map(&:to_i)
  end

  def calc_product seg
    seg.reduce(1, :*)
  end

  def check_span? len
    len >= 0 && len <= @num_array.length
  end
end
