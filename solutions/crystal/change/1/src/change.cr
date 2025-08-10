module Change
  def self.find_fewest_coins(target : Int32, coins : Array(Int32)) : Array(Int32)
    return [] of Int32 if target == 0
    raise ArgumentError.new("Negative change is not allowed") if target < 0

    min_coins = Array.new(target + 1, Int32::MAX)
    min_coins[0] = 0
    coin_combination = Array.new(target + 1) { [] of Int32 }

    (1..target).each do |i|
      coins.each do |coin|
        if coin <= i && min_coins[i - coin] != Int32::MAX && min_coins[i - coin] + 1 < min_coins[i]
          min_coins[i] = min_coins[i - coin] + 1
          coin_combination[i] = coin_combination[i - coin].dup << coin
        end
      end
    end

    raise ArgumentError.new("Change cannot be made with given coins") if min_coins[target] == Int32::MAX
    coin_combination[target].sort
  end
end