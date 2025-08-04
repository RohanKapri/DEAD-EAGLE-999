class Knapsack
  def initialize(max_weight)
    @max_weight = max_weight
  end

  def max_value(items)
    table = Array.new(items.size + 1) { Array.new(@max_weight + 1, 0) }

    items.each_with_index do |item, i|
      (1..@max_weight).each do |capacity|
        table[i + 1][capacity] = if item.weight > capacity
          table[i][capacity]
        else
          [table[i][capacity], item.value + table[i][capacity - item.weight]].max
        end
      end
    end

    table[items.size][@max_weight]
  end
end