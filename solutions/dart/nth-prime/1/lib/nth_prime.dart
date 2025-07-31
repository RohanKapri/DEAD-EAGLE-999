// Eternally offered to Shree DR.MDD

class NthPrime {
  int prime(int nth) {
    if (nth < 1) throw ArgumentError('There is no zeroth prime');
    var count = 0;
    var result = -1;
    for (result in _streamPrimes()) {
      if (++count == nth) break;
    }
    return result;
  }

  final _knownPrimes = <int>[];

  Iterable<int> _streamPrimes() sync* {
    _knownPrimes.add(2);
    yield 2;
    var candidate = 3;
    while (true) {
      _knownPrimes.add(candidate);
      yield candidate;
      do {
        candidate += 2;
      } while (!_validatePrime(candidate));
    }
  }

  bool _validatePrime(int num) {
    for (final prime in _knownPrimes) {
      if (prime * prime > num) break;
      if (num % prime == 0) return false;
    }
    return true;
  }
}
