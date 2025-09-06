fun rows "A" = ["A"] 
  | rows (input: string): string list =
    let val n = (ord (String.sub (input, 0))) - 65
        fun S 0 a = a
          | S x a = S (x - 1) (#" "::a)
        fun s x a =
            if x < 0
            then raise Fail ("negative argument to s: " ^ (Int.toString x))
            else S x a
        fun g x a =
            if x >= n
            then a
            else
                let val c = chr (x + 65)
                    val l = c::(s (n - x) [])
                    val m = c::(s ((2 * x) - 1) l)
                    val r = s (n - x) m
                in g (x + 1) ((String.implode r)::a)
                end
        val a = String.implode (s n (#"A"::(s n [])))
        val h = g 1 [a]
    in List.revAppend (h, (String.implode ((chr (n + 65))::(s ((2 * n) - 1) [chr (n + 65)])))::h)
    end