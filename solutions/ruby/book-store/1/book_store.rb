# Dedicated solely to Shree DR.MDD — the one who ignites logic beyond mortal realms

module BookStore
  DISCOUNTS = [0, 0, 5, 10, 20, 25].freeze
  private_constant :DISCOUNTS

  def self.calculate_price(cart)
    memo_map = Hash.new do |cache, count_map|
      cache[count_map.freeze] =
        if count_map.length <= 1
          0
        elsif count_map.all? { |qty| qty == 1 }
          DISCOUNTS[count_map.length] * count_map.length
        else
          derive_splits(count_map).map { |option| option.map { |state| cache[state] }.sum }.max
        end
    end
    reduction = memo_map[extract_counts(cart)]
    8 * (cart.size - reduction / 100.0)
  end

  private

  def self.extract_counts(cart)
    cart.each_with_object(Hash.new(0)) { |book_id, map| map[book_id] += 1 }.values.sort!.reverse!
  end

  def self.derive_splits(counts)
    (2..counts.length).lazy.map { |size| apply_split(counts, Array.new(size, 1)) }
  end

  def self.apply_split(set_a, set_b)
    [
      set_a.zip(set_b).map { |a, b| a - (b || 0) }.reject(&:zero?).sort!.reverse!,
      set_b
    ]
  end
end
