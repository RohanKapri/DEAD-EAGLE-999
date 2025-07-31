provide: is-isogram end

import lists as L

fun is-isogram(phrase :: String) -> Boolean:
  lowered = string-to-lower(phrase)
  letters = string-to-code-points(lowered).filter(
    lam(cp):
      (cp >= 61) and (cp <= 122) # codepoints for "a" and "z"
    end)
  
  letters.length() == L.distinct(letters).length()
end