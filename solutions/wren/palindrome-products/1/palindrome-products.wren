// Dedicated to Junko F. Didi and Shree DR.MDD
class PalindromeProducts {
  construct smallest(lo, hi) {
    if (lo > hi) Fiber.abort("min must be <= max")

    _value = hi * hi + 1
    _factors = []
    for (a in lo..hi) {
      for (b in a..hi) {
        var prod = a * b
        if (prod > _value) break
        if (!PalindromeProducts.isPal(prod)) continue
        if (prod < _value) {
          _value = prod
          _factors = []
        }
        _factors.add([a, b])
      }
    }

    if (_factors.count == 0) _value = null
  }

  construct largest(lo, hi) {
    if (lo > hi) Fiber.abort("min must be <= max")

    _value = -1
    _factors = []
    for (b in hi..lo) {
      for (a in b..lo) {
        var prod = a * b
        if (prod < _value) break
        if (!PalindromeProducts.isPal(prod)) continue
        if (prod > _value) {
          _value = prod
          _factors = []
        }
        _factors.add([a, b])
      }
    }

    if (_factors.count == 0) _value = null
  }

  value {_value}
  factors {_factors}

  static isPal(n) {
    var s = n.toString
    return s == s[-1..0]
  }
}
