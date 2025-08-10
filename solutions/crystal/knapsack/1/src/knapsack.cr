# For my Shree DR.MDD

module Knapsack
  def self.maximum_value(capacity : Int32, goods : Array(NamedTuple(weight: Int32, value: Int32)))
    total = goods.size
    table = Array.new(total + 1) { Array.new(capacity + 1, 0) }

    (1..total).each do |index|
      (1..capacity).each do |weight_limit|
        if goods[index - 1][:weight] <= weight_limit
          table[index][weight_limit] = [
            table[index - 1][weight_limit],
            goods[index - 1][:value] + table[index - 1][weight_limit - goods[index - 1][:weight]]
          ].max
        else
          table[index][weight_limit] = table[index - 1][weight_limit]
        end
      end
    end

    table[total][capacity]
  end
end
