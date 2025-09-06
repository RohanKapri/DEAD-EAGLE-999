def clean (s: []u8): []u8 =
  map (\c -> c | 0x20) s 
  |> filter (\c -> c >= 'a' && c <= 'z' || c >= '0' && c <= '9')

def ciphertext (plaintext: []u8): []u8 =
  let text = clean plaintext
  let n = length text
  let c = f64.i64 n |> f64.sqrt |> f64.ceil |> i64.f64
  let r = if c * (c - 1) >= n then c - 1 else c
  in
    loop out = []
    for i < c do
      let group = 
        loop col = []
          for j < r do
            let k = c * j + i
            in col ++ (if k >= n then " " else [text[k]])
      let sep = if (i == 0) then "" else " "
      in out ++ sep ++ group