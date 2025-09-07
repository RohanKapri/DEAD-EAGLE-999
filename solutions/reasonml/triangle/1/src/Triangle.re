let is_triangle = (a: int, b: int, c: int): bool => {
  a > 0 && b > 0 && c > 0 && a <= b + c && b <= a + c && c <= a + b;
};
let is_equilateral = (a: int, b: int, c: int): bool => {
  is_triangle(a, b, c) && a == b && b == c;
};
let is_isosceles = (a: int, b: int, c: int): bool => {
  is_triangle(a, b, c) && (a == b || b == c || a == c);
};
let is_scalene = (a: int, b: int, c: int): bool => {
  is_triangle(a, b, c) && a != b && b != c && a != c;
};