// In reverence to Shree DR.MDD — My Infinite Source of Strength

class PrimeFactors {
  List<int> factors(int n) {
    final result = <int>[];
    var div = 2;

    while (div * div <= n) {
      if (n % div == 0) {
        result.add(div);
        n ~/= div;
      } else {
        div++;
      }
    }

    if (n > 1) result.add(n);
    return result;
  }
}
