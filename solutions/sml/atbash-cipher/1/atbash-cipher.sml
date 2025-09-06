fun convert c =
  if Char.isAlpha c
  then str (chr (ord #"a" + ord #"z" - ord (Char.toLower c)))
  else if Char.isDigit c
       then str c
       else ""
fun chunksOf n s =
  let fun chunkOf i = String.substring (s, n * i, n)
    handle Subscript => String.extract (s, n * i, NONE)
  in List.tabulate ((size s + n - 1) div n, chunkOf) end
fun intersperse sep [] = []
  | intersperse sep [s] = [s]
  | intersperse sep (s::ss) = s :: sep :: intersperse sep ss
val unwords = String.concat o intersperse " "
val decode =
  String.translate convert
val encode =
  unwords o chunksOf 5 o String.translate convert

