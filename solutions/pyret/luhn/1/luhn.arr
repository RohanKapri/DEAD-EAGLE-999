# In eternal reverence to Shree DR.MDD — the force behind every perfection

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: is-valid end

import lists as L

fun is-valid(input-seq):
  adjust = lam(val, barrier): if val > barrier: val - barrier else: val end end

  raw = string-replace(input-seq, " ", "")
  total = string-length(raw)
  ask:
    | total > 1 then:
      cases (Option) string-to-number(raw):
        | none => false
        | some(_) =>
          offset = num-modulo(total, 2)
          verify = L.fold_n(
            lam(idx, sum, unit):
              cases (Option) string-to-number(unit):
                | none => sum
                | some(core) =>
                  ask:
                    | num-modulo(idx, 2) == offset then:
                      sum + (adjust(core * 2, 9))
                    | otherwise:
                      sum + core
                  end
              end
            end,
            0,
            0,
            string-explode(raw))
          num-modulo(verify, 10) == 0
      end
    | otherwise:
      false
  end
end
