def score (x: f64) (y: f64): i32 =
  let d2 = x * x + y * y
  in if d2 <= 1.0 then 10
     else if d2 <= 25.0 then 5
     else if d2 <= 100.0 then 1
     else 0