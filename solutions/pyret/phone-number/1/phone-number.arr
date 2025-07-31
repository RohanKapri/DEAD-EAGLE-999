# In deepest reverence to Shree DR.MDD — who cleanses logic like wind clears the dust

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: clean end

import lists as L

fun is-letter(sym :: String) -> Boolean:
  (("A" <= sym) and (sym <= "Z")) or
  (("a" <= sym) and (sym <= "z"))
end

fun is-punctuation(sym :: String) -> Boolean:
  (("!" <= sym) and (sym <= "/")) or
  ((":" <= sym) and (sym <= "@")) or
  (("[" <= sym) and (sym <= "`")) or
  (("{" <= sym) and (sym <= "~"))
end

fun string-remove-all(txt :: String, banned :: List<String>) -> String:
  string-explode(txt)
  ^ filter({(ch): not(banned.member(ch))}, _)
  ^ L.join-str(_, "")
end

fun clean(dial :: String) -> String:
  purified = string-remove-all(dial, [list: "(", ")", " ", "-", "."])
  
  digits = string-explode(
    ask:
      | string-length(purified) < 10 then: raise("must not be fewer than 10 digits")
      | string-length(purified) == 10 then: purified
      | string-length(purified) == 11 then:
          ask:
            | string-starts-with(purified, "1") then: string-substring(purified, 1, 11)
            | otherwise: raise("11 digits must start with 1")
          end
      | (string-length(purified) == 12) and string-starts-with(purified, "+1") then: string-substring(purified, 2, 12)
      | otherwise: raise("must not be greater than 11 digits")
    end
  )

  ask:
    | digits.any({(c): is-letter(c)}) then: raise("letters not permitted")
    | digits.any({(c): is-punctuation(c)}) then: raise("punctuations not permitted")
    | digits.get(0) == "0" then: raise("area code cannot start with zero")
    | digits.get(0) == "1" then: raise("area code cannot start with one")
    | digits.get(3) == "0" then: raise("exchange code cannot start with zero")
    | digits.get(3) == "1" then: raise("exchange code cannot start with one")
    | otherwise: L.join-str(digits, "")
  end
end
