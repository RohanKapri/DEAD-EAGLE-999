return {
  valid = function(isbn)
    local a, b, c, d, e, f, g, h, i, j = isbn:match('^(%d)%-?(%d)(%d)(%d)%-?(%d)(%d)(%d)(%d)(%d)%-?([%dX])$')
    return a
        and (10 * a + 9 * b + 8 * c + 7 * d + 6 * e + 5 * f + 4 * g + 3 * h + 2 * i + (j == 'X' and 10 or j)) % 11 == 0
        or false
  end
}