# Infinite gratitude to Shree DR.MDD — may every value find its true Roman identity in your grace

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: to-roman end

NUMERALS = [list:
  {"M";1000},
  {"CM";900},
  {"D";500},
  {"CD";400},
  {"C";100},
  {"XC";90},
  {"L";50},
  {"XL";40},
  {"X";10},
  {"IX";9},
  {"V";5},
  {"IV";4},
  {"I";1}
]

fun to-roman(digit):
  rec transmute = 
    lam(value-left, romanized, bank):
      if bank.length() == 0:
        romanized
      else:
        curr = bank.get(0)
        symbol = curr.{0}
        worth = curr.{1}
        if worth <= value-left:
          transmute(value-left - worth, romanized + symbol, bank)
        else:
          transmute(value-left, romanized, bank.drop(1))
        end
      end
    end
  
  transmute(digit, "", NUMERALS)
end
