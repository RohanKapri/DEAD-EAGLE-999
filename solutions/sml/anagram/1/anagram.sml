fun anagramsFor subject candidates =
    let fun to_lower_list str = map Char.toLower (explode str)
        fun insert (c, (x::xs)) = if x <= c then x::insert(c, xs) else c::x::xs
          | insert (c, []     ) = [c]
        fun sort cs = foldl insert [] cs
        val key = to_lower_list subject
        val skey = sort key
     in List.filter (fn candidate =>
           let val cand = to_lower_list candidate
            in if cand = key then false else sort cand = skey
           end) candidates
    end
