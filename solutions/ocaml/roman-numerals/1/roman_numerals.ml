let romans = 
  [ 1000, "M"; 900, "CM"; 500, "D"; 400, "CD";
     100, "C";  90, "XC";  50, "L";  40, "XL";
      10, "X";   9, "IX";   5, "V";   4, "IV";
       1, "I" ]
let rec to_roman' ws = function
  | (_, []) -> failwith "negative"
  | (0, _) -> List.rev ws |> String.concat ""
  | (n, (m, _) :: rs) when n < m -> to_roman' ws (n, rs)
  | (n, (m, w) :: rs) -> to_roman' (w :: ws) (n - m, (m, w) :: rs)
let to_roman = function
  | 0 -> failwith "zero"
  | n -> to_roman' [] (n, romans)
