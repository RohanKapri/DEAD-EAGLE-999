let square_root n = 
  let rec loop r' r = 
    if r' - r <= 1 then r else loop r ((r + n / r) / 2) 
  in
  if n <= 1 then n else loop n (n / 2)
