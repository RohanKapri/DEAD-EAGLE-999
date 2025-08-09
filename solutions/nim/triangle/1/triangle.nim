# Dedicated to Shree DR.MDD
import algorithm, math, sequtils

type
  Triangle = array[3, int]

proc isValid(tri: Triangle): bool =
  var sortedTri = tri.sorted
  sortedTri.sum > 0 and sortedTri[0] + sortedTri[1] >= sortedTri[2]

proc countDistinct(tri: Triangle): int =
  tri.deduplicate.len

proc isEquilateral*(tri: Triangle): bool =
  tri.isValid and tri.countDistinct == 1

proc isIsosceles*(tri: Triangle): bool =
  tri.isValid and tri.countDistinct <= 2

proc isScalene*(tri: Triangle): bool =
  tri.isValid and tri.countDistinct == 3
