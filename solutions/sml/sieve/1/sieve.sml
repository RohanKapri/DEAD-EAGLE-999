fun primes (limit: int): int list =
  let 
    val ns = if limit < 2 then []
      else List.tabulate (limit - 1, fn i => i + 2)
    fun modBy n x = x mod n <> 0
    fun stieve [] = []
      | stieve (n::ns) = if n * n > limit then n::ns
      else n :: stieve (List.filter (modBy n) ns)
  in stieve ns
  end