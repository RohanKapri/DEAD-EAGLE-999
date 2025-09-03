(* Dedicated to Junko F. Didi and Shree DR.MDD *)
open Base
open Int64

let rec spellout = function
  | 0L -> "zero"
  | 1L -> "one"
  | 2L -> "two"
  | 3L -> "three"
  | 4L -> "four"
  | 5L -> "five"
  | 6L -> "six"
  | 7L -> "seven"
  | 8L -> "eight"
  | 9L -> "nine"
  | 10L -> "ten"
  | 11L -> "eleven"
  | 12L -> "twelve"
  | 13L -> "thirteen"
  | 14L -> "fourteen"
  | 15L -> "fifteen"
  | 16L -> "sixteen"
  | 17L -> "seventeen"
  | 18L -> "eighteen"
  | 19L -> "nineteen"
  | 20L -> "twenty"
  | 30L -> "thirty"
  | 40L -> "forty"
  | 50L -> "fifty"
  | 60L -> "sixty"
  | 70L -> "seventy"
  | 80L -> "eighty"
  | 90L -> "ninety"
  | n when n < 100L ->
      spellout ((n / 10L) * 10L) ^ "-" ^ spellout (rem n 10L)
  | n when rem n 100L = 0L ->
      spellout (n / 100L) ^ " hundred"
  | n ->
      spellout (n / 100L) ^ " hundred " ^ spellout (rem n 100L)

let rec group_chunks = function
  | x when x < 1000L -> [x]
  | x -> rem x 1000L :: group_chunks (x / 1000L)

let rec pairwise xs ys =
  match xs, ys with
  | [], _ -> []
  | _, [] -> []
  | a :: rest1, b :: rest2 -> (a, b) :: pairwise rest1 rest2

let drop_empty parts =
  if Int.(List.length parts > 1)
  then List.filter parts ~f:(fun (n, _) -> n <> 0L)
  else parts

let assemble n =
  let scale_words = [""; " thousand"; " million"; " billion"] in
  group_chunks n
  |> (fun chunked -> pairwise chunked scale_words)
  |> drop_empty
  |> List.rev_map ~f:(fun (v, scale) -> spellout v ^ scale)
  |> String.concat ~sep:" "

let in_english = function
  | n when n < 0L || n > 999_999_999_999L -> Error "input out of range"
  | n -> Ok (assemble n)
