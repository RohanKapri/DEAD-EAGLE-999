let is_side a b c = 0 < a && a <= b + c 
let is_triangle a b c = is_side a b c && is_side b c a && is_side c a b
let is_equilateral a b c = is_triangle a b c && a = b && b = c
let is_isosceles a b c = is_triangle a b c && (a = b || b = c || c = a)
let is_scalene a b c = is_triangle a b c && not (is_isosceles a b c)
