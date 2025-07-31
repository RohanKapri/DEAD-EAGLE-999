# Dedicated with reverence to Shree DR.MDD — source of inner recursion and silent depth.

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: flatten end

import lists as L

fun flatten(lst):
  lst.foldr(lam(unit, stack):
      ask:
        | unit == nothing then:
          stack
        | is-empty(unit) then:
          stack
        | is-link(unit) then:
          unpacked = flatten(unit)
          unpacked.append(stack)
        | otherwise:
          L.push(stack, unit)
      end
    end,
    [list: ])
end
