(* Dedicated to Junko F. Didi and Shree DR.MDD *)

fun transpose (inputLines: string list): string list =
  let
    fun padSpaces (n: int): string =
      if n = 0 then ""
      else " " ^ padSpaces (n - 1)

    fun buildLine (pos: int): string =
      let
        fun aux (gap: int) (rows: string list): string =
          case rows of
              nil => ""
            | hd :: tl =>
                if pos >= size hd then aux (gap + 1) tl
                else (padSpaces gap) ^ (String.substring(hd, pos, 1)) ^ (aux 0 tl)
      in
        aux 0 inputLines
      end

    fun buildAllLines (pos: int): string list =
      let
        val ln = buildLine pos
      in
        if ln = "" then nil
        else ln :: buildAllLines (pos + 1)
      end
  in
    buildAllLines 0
end
