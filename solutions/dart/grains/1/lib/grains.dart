BigInt square(final int n) {
  if (n < 1 || n > 64)
    throw ArgumentError('square must be between 1 and 64', 'message');
  return BigInt.from(1) << n - 1;
}

BigInt total() {
  BigInt total = BigInt.zero;
  for (int i = 1; i <= 64; i++) {
    total += (BigInt.from(1) << i - 1);
  }
  return total;
}