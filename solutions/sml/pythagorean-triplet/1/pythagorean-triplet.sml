fun tripletsWithSum (n: int): (int * int * int) list =
  let fun findTriplets (a, triplets) =
    let val b = n * (n - 2 * a) div (2 * (n - a))
        val c = n - a - b
    in  if a >= b
        then (List.rev triplets)
        else if a * a + b * b = c * c
             then findTriplets (a + 1, (a, b, c) :: triplets)
             else findTriplets (a + 1, triplets)
    end
  in
    findTriplets (3, [])
  end