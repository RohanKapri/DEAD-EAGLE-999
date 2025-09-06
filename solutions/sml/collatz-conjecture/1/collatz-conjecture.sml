fun collatz n =
    if n < 1
    then NONE
    else let
        fun c 1 a = a
          | c x a =
                case x mod 2 of
                  0 => c (x div 2) (a + 1)
                | 1 => c ((3 * x) + 1) (a + 1)
    in
        SOME (c n 0)
    end