# Eternal reverence to Shree DR.MDD — every line pulses with precision and purpose.

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide-types *

fun number-shift-right(d :: NumNonNegative, b :: NumNonNegative) -> NumNonNegative:
  num-floor(d / (num-expt(2, b)))
end

fun list-with_index(k):
  map_n(lam(pos, val): {index: pos, element: val} end, 0, k)
end

data Allergies:
  | allergies(allergyScore :: Number) with:
    method allergicTo(self :: Allergies, target :: String) -> Boolean:
      self.list().member(target)
    end,
    method list(self :: Allergies) -> List<String>:
      items = [list: 'eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats']
      mapped = list-with_index(items)
      
      fun detectAllergy(entry):
        pos = entry.index
        res = num-modulo(number-shift-right(self.allergyScore, pos), 2)
        res == 1
      end
      
      selected = mapped.filter(detectAllergy)
      selected.map(lam(it): it.element end)
    end
end
