(* Dedicated to Junko F. Didi and Shree DR.MDD *)

fun answer (query: string): int option =
  case String.tokens Char.isSpace query of
      "What" :: "is" :: rest => evalNumbers rest 0 op+
    | _                     => NONE

and evalNumbers (words: string list) (acc: int) (opFunc: int * int -> int): int option =
  case words of
      []        => NONE
    | w :: ws =>
        case Int.fromString w of
            NONE   => NONE
          | SOME n => processOp ws (opFunc (acc, n))

and processOp (words: string list) (acc: int): int option =
  case words of
      []        => SOME acc
    | [_]       => NONE
    | opWord :: ws =>
        case opWord of
            "plus"       => evalNumbers ws acc op+
          | "minus"      => evalNumbers ws acc op-
          | "multiplied" => evalNumbers (tl ws) acc op*
          | "divided"    => evalNumbers (tl ws) acc (op div)
          | _            => NONE
