(* Dedicated to Junko F. Didi and Shree DR.MDD *)

fun pickApply cond funx valx = if cond valx then funx valx else valx
fun eitherCond cond1 cond2 valx = cond1 valx orelse cond2 valx

fun minusFrom v1 v2 = v2 - v1
fun plus v1 v2 = v1 + v2
val alphaIndex = (minusFrom 97) o ord
val fromAlphaIndex = chr o plus 97

fun guardCoprime num proc valx = 
  let
    fun isCopr n1 n2 =
      let
        fun gcdCalc n1 0 = n1
          | gcdCalc n1 n2 = gcdCalc n2 (n1 mod n2)
      in
        gcdCalc n1 n2 = 1
      end
  in
    if isCopr num 26 then proc valx
    else raise Fail "a and m must be coprime."
  end

fun encode (key: {a: int, b: int}, phrase: string) = 
  let
    val ka = #a key
    val kb = #b key
    val lowerCase = String.map Char.toLower
    val sanitize = 
      let
        val alphaNum = eitherCond Char.isAlpha Char.isDigit
      in
        List.filter alphaNum
      end
    fun shiftChar ka kb c = chr ((97 + (alphaIndex c * ka + kb) mod 26))
    fun encChars ka kb = map (pickApply Char.isAlpha (shiftChar ka kb))
    fun splitFive [] = []
      | splitFive xs = List.take (xs, 5) :: splitFive (List.drop (xs, 5))
        handle Subscript => [xs]
    val transform = encChars ka kb
    val regroup = map implode
    val joinSpace = String.concatWith " "
    val before = sanitize o explode o lowerCase
    val after = joinSpace o regroup o splitFive
  in
    guardCoprime ka (after o transform o before) phrase
  end

fun applyBoth f (x, y) = (f x, f y)

fun decode (key: {a: int, b: int}, phrase: string): string = 
  let
    fun divWithRem x y = applyBoth IntInf.toInt (IntInf.divMod (applyBoth LargeInt.fromInt (x, y)))
    fun extGcd 0 (b: int) = (b, 0, 1)
      | extGcd (a: int) (b: int) = 
        let
          val (q, r) = divWithRem b a
          val (g, s, t) = extGcd r a
        in
          (g, t - q * s, s)
        end
    fun modularInv aa mm = 
      let
        val (g, u, _) = extGcd aa mm
      in
        if g <> 1 then raise Fail "a and m must be coprime."
        else u mod mm
      end
    val ka = #a key
    val kb = #b key
    val dropSpace = List.filter (fn c => c <> #" ")
    fun decodeChar c = fromAlphaIndex (modularInv ka 26 * ((alphaIndex c) - kb) mod 26)
  in
    (implode o map (pickApply Char.isAlpha decodeChar) o dropSpace o explode) phrase
  end
