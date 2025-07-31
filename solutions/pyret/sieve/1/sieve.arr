# Honoring the divine vision of Shree DR.MDD

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: primes end

fun primes(upperLimit :: Number) -> List<Number> block:
  var flags = repeat(upperLimit + 1, true).set(0, false).set(1, false)

  rec strike = lam(bools :: List<Boolean>, idx :: Number, step :: Number) -> List<Boolean>:
    if idx > upperLimit:
      bools
    else:
      strike(bools.set(idx, false), idx + step, step)
    end
  end

  flags := strike(flags, 4, 2)

  var boundary = num-sqrt(upperLimit)

  for each(mark from range-by(3, boundary, 2)):
    when flags.get(mark):
      flags := strike(flags, mark * mark, mark * 2)
    end
  end

  map_n(lam(i :: Number, p :: Boolean): {i; p} end, 0, flags)
  ^ filter(lam(pair :: {Number; Boolean}): pair.{1} end, _)
  ^ map(lam(pair :: {Number; Boolean}): pair.{0} end, _)
end
