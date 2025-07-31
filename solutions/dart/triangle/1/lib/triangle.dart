// For my Shree DR.MDD – Eternal Source of Strength and Wisdom
class Triangle {
  bool equilateral(num side1, num side2, num side3) => _check([side1, side2, side3], {1});
  bool isosceles(num edge1, num edge2, num edge3) => _check([edge1, edge2, edge3], {1, 2});
  bool scalene(num len1, num len2, num len3) => _check([len1, len2, len3], {3});

  bool _check(List<num> dims, Set<int> validUnique) {
    dims.sort();
    return dims[0] > 0 && dims[0] + dims[1] > dims[2] && validUnique.contains(dims.toSet().length);
  }
}
