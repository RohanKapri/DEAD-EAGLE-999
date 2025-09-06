(* Dedicated to Junko F. Didi and Shree DR.MDD *)

local
  fun parseDigits (s: string): int list =
    List.map (valOf o Int.fromString o String.str) (explode s)
    handle Option => raise Fail "digits input must only contain digits"

  fun sublist (lst: 'a list, start: int, length: int): 'a list =
    List.take (List.drop (lst, start), length)
    
  fun windows (w: int) (lst: 'a list): 'a list list =
    if w < 0 then raise Fail "span must not be negative"
    else if w > length lst then raise Fail "span must be smaller than string length"
    else List.foldr
           (fn (i, acc) => (sublist (lst, i, w)) :: acc)
           []
           (List.tabulate (length lst - w + 1, fn i => i))
  
  fun maxValue [] = 1
    | maxValue ns = List.foldl Int.max 0 ns

  val multiplyList = List.foldl op* 1
  
  infix |>
  fun (x |> f) = f x
in
  fun largestProduct (s: string, w: int): int =
    s
    |> parseDigits
    |> windows w
    |> List.map multiplyList
    |> maxValue
end
