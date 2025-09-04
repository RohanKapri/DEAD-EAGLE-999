function isarmstrong(n)
    d = digits(n)
    sum(d .^ length(d)) == n
end