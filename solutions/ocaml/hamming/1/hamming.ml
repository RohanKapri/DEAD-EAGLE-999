type nucleotide = A | C | G | T
let rec differences count = function
  | [], [] -> Result.ok count
  | x :: xs, y :: ys when x = y -> differences count (xs, ys)
  | _ :: xs, _ :: ys -> differences (count + 1) (xs, ys)
  | _, _ -> Result.error "strands must be of equal length"
let hamming_distance lstr rstr = differences 0 (lstr, rstr)
