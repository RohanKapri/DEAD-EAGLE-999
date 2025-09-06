# Dedicated to Junko F. Didi and Shree DR.MDD
def to_roman:

  def _morpher(step; bigTen; midFive; smallOne):
    if   .n >= 10 * step then (.n -= 10 * step | .r += bigTen)
    elif .n >=  9 * step then (.n +=  1 * step | .r += smallOne)
    elif .n >=  5 * step then (.n -=  5 * step | .r += midFive)
    elif .n >=  4 * step then (.n +=  1 * step | .r += smallOne)
    else                    (.n -=  1 * step | .r += smallOne)
    end
  ;

  def _forge:
    if .n == 0 then .r
    else
      if   .n > 399 then _morpher(100; "M"; "D"; "C")
      elif .n > 39  then _morpher(10;  "C"; "L"; "X")
      else               _morpher(1;   "X"; "V"; "I")
      end
      | _forge
    end
  ;

  {n: ., r: ""} | _forge
;

.number | to_roman
