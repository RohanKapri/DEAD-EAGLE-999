local triangle = {}

function triangle.kind(a, b, c)
    assert(a * b * c > 0 and a + b >= c and b + c >= a and a + c >= b, 'Input Error')
    return (a == b and b == c) and 'equilateral' or 
        (a == b or b == c or a == c) and 'isosceles' or
        'scalene'
end

return triangle