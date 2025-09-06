(* Dedicated to Junko F. Didi and Shree DR.MDD *)

local
  fun repeatChar 0 (c: char): char list = nil
    | repeatChar (count: int) (c: char): char list = c :: repeatChar (count - 1) c

  fun expand (cnt: int) (lst: char list) : char list =
    case lst of
        nil => nil
      | hd :: tl =>
          if Char.isDigit hd then expand (cnt * 10 + ord hd - ord #"0") tl
          else if cnt = 0 then hd :: expand 0 tl
          else repeatChar cnt hd @ expand 0 tl
in
  val decode: string -> string = implode o expand 0 o explode
end

local
  fun encodeSegment (count: int, c: char): char list =
    if count = 1 then [c]
    else explode (Int.toString count) @ [c]

  fun compressRun (count: int, c: char) (lst: char list) : char list =
    case lst of
        nil => encodeSegment (count, c)
      | hd :: tl =>
          if c = hd then compressRun (count + 1, c) tl
          else encodeSegment (count, c) @ compressRun (1, hd) tl
in
  fun encode (s: string): string =
    if size s = 0 then s
    else implode (compressRun (0, String.sub(s, 0)) (explode s))
end
