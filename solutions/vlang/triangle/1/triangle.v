module main
fn is_valid(a f64, b f64, c f64) bool {
    return (a > 0) && (b > 0) && (c > 0) && (a <= b + c) && (b <= a + c) && (c <= a + b)
}
fn is_isosceles(a f64, b f64, c f64) bool {
    return is_valid(a, b, c) && ((a == b) || (a == c) || (b == c))
}
fn is_equilateral(a f64, b f64, c f64) bool {
    return is_valid(a, b, c) && ((a == b) && (a == c) && (b == c))
}
fn is_scalene(a f64, b f64, c f64) bool {
    return is_valid(a, b, c) && ((a != b) && (a != c) && (b != c))
}