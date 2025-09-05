class Change {
  static findMinimumCoins(amount, coins) {
    if (amount < 0) Fiber.abort("target can't be negative")
    var arr = [[]]
    for (i in 0...amount) {
      arr.insert(0, (coins.where { |x| x <= arr.count && arr[x - 1] }.map { |x| arr[x - 1] + [x] }.toList.sort { |a, b| a.count < b.count } + [null])[0])
    }
    return arr[0] || Fiber.abort("can't make target with given coins")
  }
}