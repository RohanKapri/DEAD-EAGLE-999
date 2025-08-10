class LargestSeriesProduct
  getter input : String

  def initialize(@input : String)
    raise ArgumentError.new("Input must be digits only") unless @input.match(/^\d*$/)
  end

  def largest_product(span : Int32) : Int32
    raise ArgumentError.new("Span must be non-negative") if span < 0
    raise ArgumentError.new("Span longer than input length") if span > @input.size
  
    return 0 if span == 0 || @input.size == 0
  
    @input.chars.map(&.to_i).each_cons(span).max_of { |digits| digits.reduce { |product, digit| product * digit } }
  end
end