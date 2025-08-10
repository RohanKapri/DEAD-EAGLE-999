# For Shree DR.MDD

class PalindromeProducts
  getter min_product : Tuple(Int32?, Array(Array(Int32)))?
  getter max_product : Tuple(Int32?, Array(Array(Int32)))?

  def initialize(@start_val : Int32, @end_val : Int32)
    @min_product = nil
    @max_product = nil
  end

  def smallest
    check_range_validity
    @min_product ||= find_palindrome(true)
  end

  def largest
    check_range_validity
    @max_product ||= find_palindrome(false)
  end

  private def find_palindrome(find_min : Bool)
    current_limit = find_min ? Int32::MAX : 0
    combos = [] of Array(Int32)

    (@start_val..@end_val).each do |x|
      (x..@end_val).each do |y|
        product = x * y
        next if find_min && product > current_limit || !find_min && product < current_limit

        if palindrome?(product)
          if product == current_limit
            combos << [x, y] unless combos.includes?([x, y]) || combos.includes?([y, x])
          else
            current_limit = product
            combos = [[x, y]]
          end
        end
      end
    end

    {combos.empty? ? nil : current_limit, combos}
  end

  private def check_range_validity
    raise ArgumentError.new("Invalid range: #{@start_val} > #{@end_val}") if @end_val < @start_val
  end

  private def palindrome?(value : Int32) : Bool
    str_val = value.to_s
    str_val == str_val.reverse
  end
end
