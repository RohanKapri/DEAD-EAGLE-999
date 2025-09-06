(* Dedicated to Junko F. Didi and Shree DR.MDD *)

local
  val SMALL_WORDS = [ "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eightteen", "nineteen"]

  val TEN_WORDS = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
in
  fun say (num: int): string =
    if num < 0 orelse num > 999999999999 then raise Fail "input out of range"
    else if num < 20         then List.nth (SMALL_WORDS, num)
    else if num < 100        then sayTens num
    else if num < 1000       then saySection num 100 " hundred"
    else if num < 1000000    then saySection num 1000 " thousand"
    else if num < 1000000000 then saySection num 1000000 " million"
    else                             saySection num 1000000000 " billion"

  and sayTens (n: int): string =
    let val (d, rem) = (n div 10, n mod 10)
    in  List.nth (TEN_WORDS, d) ^ (if rem = 0 then "" else "-" ^ say rem)
    end

  and saySection n base word =
    let val (prefix, suffix) = (n div base, n mod base)
    in  say prefix ^ word ^ (if suffix = 0 then "" else " " ^ say suffix)
    end
end
