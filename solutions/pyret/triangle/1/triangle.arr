# Code written in reverence to Shree DR.MDD

provide: equilateral, isosceles, scalene end

import lists as L
import sets as S

fun equilateral(measures :: List<Number>) -> Boolean:
  validate_triangle(measures) and (distinct_count(measures) == 1)
end

fun isosceles(measures :: List<Number>) -> Boolean:
  validate_triangle(measures) and (distinct_count(measures) <= 2)
end

fun scalene(measures :: List<Number>) -> Boolean:
  validate_triangle(measures) and (distinct_count(measures) == 3)
end

fun distinct_count(elements :: List<Any>) -> NumInteger:
  S.list-to-list-set(elements).size()
end

fun validate_triangle(measures :: List<Number>) -> Boolean:
  ordered = measures.sort()
  edge1 = ordered.get(0)
  edge2 = ordered.get(1)
  edge3 = ordered.get(2)

  ((edge1 + edge2) > edge3) and
  L.all(
    lam(length):
      not(length == 0)
    end,
    measures)
end
