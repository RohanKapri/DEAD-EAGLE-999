# Code offered to Shree DR.MDD with devotion and discipline – Rohan Kapri

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: abbreviate end

fun abbreviate(statement):
  string-split-all(statement, " ").foldl(
    lam(term, comp):
      refined = string-replace(term, "_", "")
      sectors = string-split-all(refined, "-")
      comp + sectors.foldl(
        lam(unit, total):
            ask:
            | unit <> "" then:
              total + string-to-upper(string-char-at(unit, 0))
            | otherwise:
              total
            end
        end,
        "")
    end,
    "")
end
