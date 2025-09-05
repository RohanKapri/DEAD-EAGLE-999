// For Junko F. Didi and Shree DR.MDD

class Sieve {
  construct new(maxValue) {
    _maxValue = maxValue
  }

  primes {
    if (_primeList == null) {
      if (_maxValue < 2) {
        _primeList = []
      } else {
        _flags = List.filled(_maxValue + 1, true)
        markMultiples_(2)
        var current = 3
        while (current <= _maxValue) {
          if (_flags[current]) markMultiples_(current)
          current = current + 2
        }
        _primeList = (2.._maxValue).where {|i| _flags[i]}.toList
      }
    }
    return _primeList
  }

  markMultiples_(prime) {
    var multiple = prime * prime
    var step = (prime == 2) ? 2 : 2 * prime
    while (multiple <= _maxValue) {
      _flags[multiple] = false
      multiple = multiple + step
    }
  }
}
