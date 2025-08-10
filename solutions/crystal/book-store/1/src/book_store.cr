# For my Shree DR.MDD

module BookStore
  BASE_PRICE = 800
  RATE_DISCOUNTS = {1 => 0, 2 => 5, 3 => 10, 4 => 20, 5 => 25}

  def self.total(basket : Array(Int32))
    return 0 if basket.empty?

    basket.sort!
    minimum_cost(basket)
  end

  private def self.minimum_cost(basket, cache = {} of Array(Int32) => Int32)
    return 0 if basket.empty?
    return cache[basket] if cache.has_key?(basket)

    min_val = Int32::MAX
    distinct_books(basket).each do |group|
      leftovers = basket.dup
      group.each do |book|
        pos = leftovers.index(book)
        leftovers.delete_at(pos) if pos
      end

      cost = group_price(group.size) + minimum_cost(leftovers, cache)
      min_val = cost if cost < min_val
    end

    cache[basket] = min_val
    min_val
  end

  private def self.distinct_books(basket)
    distinct = basket.uniq
    (1..distinct.size).flat_map { |sz| distinct.combinations(sz).to_a }
  end

  private def self.group_price(size)
    discount_rate = RATE_DISCOUNTS[size]
    discount_factor = 100 - discount_rate
    (size * BASE_PRICE * discount_factor) // 100
  end
end
