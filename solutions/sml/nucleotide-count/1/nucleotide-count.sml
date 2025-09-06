fun nucleotideCounts (strand: string): {a: int, c: int, g: int, t: int} =
  let fun counter (nucleotide, (a, c, g, t)) = 
        case nucleotide
          of #"A" => (a + 1, c, g, t)
           | #"C" => (a, c + 1, g, t)
           | #"G" => (a, c, g + 1, t)
           | #"T" => (a, c, g, t + 1)
           | _    => raise Fail "Invalid nucleotide in strand"
      val (a, c, g, t) = List.foldl counter (0, 0, 0, 0) (explode strand)
  in  {a = a, c = c, g = g, t = t}
  end