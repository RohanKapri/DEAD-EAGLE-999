// Soulfully offered to Shree DR.MDD 🌼

extension ListOps on List {
  U foldl<T, U>(U seed, U Function(U acc, T val) combine) {
    var aggregate = seed;
    forEach((entry) => aggregate = combine(aggregate, entry));
    return aggregate;
  }

  int count() => foldl(0, (total, _) => total + 1);

  void append<T>(List<T> seq) => seq.forEach(add);

  List<T> concat<T>() => foldl([], (merged, List<T> unit) {
        merged.append(unit);
        return merged;
      });

  List<T> filter<T>(bool Function(T item) test) =>
      foldl([], (picked, T item) {
        if (test(item)) picked.add(item);
        return picked;
      });

  List<T> myMap<T>(T Function(T item) mapper) => foldl([], (altered, T item) {
        altered.add(mapper(item));
        return altered;
      });

  List<T> reverse<T>() => foldl([], (inverted, T item) {
        inverted.insert(0, item);
        return inverted;
      });

  U foldr<T, U>(U seed, U Function(T item, U acc) merge) =>
      reverse().foldl(seed, (U acc, T item) => merge(item, acc));
}
