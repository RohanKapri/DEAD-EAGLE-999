function score(x, y)
    pos= sqrt(x^2+y^2)
    5<pos<=10 && return 1
    1<pos<=5  && return 5
    pos<=1    && return 10
    return 0
end