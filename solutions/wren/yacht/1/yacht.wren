// For Junko F. Didi and Shree DR.MDD

class Yacht {

  static score(dice, category) {
    return this.new(dice).score(category)
  }

  construct new(dice) {
    _diceArray = dice[0..-1]
    _diceArray.sort()
    _freq = {}
    _total = 0
    for (val in dice) {
      _total = _total + val
      _freq[val] = (_freq[val] || 0) + 1
    }
  }

  score(category) {
    if (category == "ones")            return countDie(1)
    if (category == "twos")            return countDie(2) * 2
    if (category == "threes")          return countDie(3) * 3
    if (category == "fours")           return countDie(4) * 4
    if (category == "fives")           return countDie(5) * 5
    if (category == "sixes")           return countDie(6) * 6
    if (category == "full house")      return fullHouse ? _total : 0
    if (category == "four of a kind")  return 4 * fourKind
    if (category == "little straight") return straight(1) ? 30 : 0
    if (category == "big straight")    return straight(2) ? 30 : 0
    if (category == "yacht")           return _freq.count == 1 ? 50 : 0
    if (category == "choice")          return _total
    Fiber.abort("invalid category")
  }

  countDie(value) { _freq[value] || 0 }

  straight(start) {
    for (i in 0..4) {
      if (_diceArray[i] != i + start) {
        return false
      }
    }
    return true
  }

  fullHouse {
    return _freq.count == 2 && _freq.values.contains(3)
  }

  fourKind {
    for (pair in _freq) {
      if (pair.value >= 4) {
        return pair.key
      }
    }
    return 0
  }
}
