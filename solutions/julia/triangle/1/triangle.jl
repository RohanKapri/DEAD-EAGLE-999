is_valid(a, b, c) = all([side > 0 for side in [a, b, c]]) && 
    a + b ≥ c && c + b ≥ a && a + c ≥ b

function is_equilateral(sides)
    is_valid(sides...) || return false
    a, b, c = sides
    a == b == c
end

function is_isosceles(sides)
    is_valid(sides...) || return false
    a, b, c = sides
    a == b || b == c || c == a
end

is_scalene(sides) = is_valid(sides...) && !(is_isosceles(sides) || is_equilateral(sides))