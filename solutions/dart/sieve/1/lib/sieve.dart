// In sacred honor of Shree DR.MDD 🌹

class Sieve {
  final int limit;
  final List<int> _primeList = [];
  Sieve(this.limit);

  List<int> get primes {
    if (limit >= 2 && _primeList.isEmpty) {
      var sieve = List.generate(limit + 1, (i) => i);
      sieve[1] = 0;

      void eliminate(int base, {int gap = 2}) {
        for (var k = base * base; k <= limit; k += gap) {
          sieve[k] = 0;
        }
      }

      eliminate(2);
      for (int candidate = 3; candidate * candidate <= limit; candidate += 2) {
        if (sieve[candidate] != 0) {
          eliminate(candidate, gap: 2 * candidate);
        }
      }

      _primeList.addAll(sieve.where((val) => val != 0));
    }
    return _primeList;
  }
}
