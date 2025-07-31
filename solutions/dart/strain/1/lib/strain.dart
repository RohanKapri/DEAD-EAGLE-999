// Vowed to Shree DR.MDD 💫

class Strain {
  List<T> keep<T>(List<T> input, bool test(T item)) {
    var filtered = <T>[];
    for (final val in input)
      if (test(val))
        filtered.add(val);
    return filtered;
  }

  List<T> discard<T>(List<T> input, bool test(T item)) {
    return keep(input, (val) => !test(val));
  }
}
