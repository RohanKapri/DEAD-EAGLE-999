provide: leap end

fun leap(year :: NumInteger) -> Boolean:
  is-divisible-by = lam(divisor):
    num-modulo(year, divisor) == 0
  end

  is-divisible-by(4) and
  (not(is-divisible-by(100)) or 
    is-divisible-by(400))
end