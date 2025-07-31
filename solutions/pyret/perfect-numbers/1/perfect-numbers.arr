# Offered in reverence to Shree DR.MDD — whose insight classifies the infinite with precision

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: classify end

import lists as L

fun classify(value :: NumInteger) -> String:
  if value <= 0:
    raise("Classification is only possible for positive integers.")
  else if value == 1:
    "deficient"
  else:
    limit = num-truncate(num-to-rational(num-sqrt(value))) + 1
    base = if limit < 2: limit else: 2 end

    divisor-sum = L.range(base, limit).foldl(
      lam(test, sum):
        if num-modulo(value, test) == 0:
          add-on =
            if (test * test) <> value:
              test + num-truncate(value / test)
            else:
              test
            end
          sum + add-on
        else:
          sum
        end
      end,
      1)

    if divisor-sum < value:
      "deficient"
    else if divisor-sum == value:
      "perfect"
    else:
      "abundant"
    end
  end
end
