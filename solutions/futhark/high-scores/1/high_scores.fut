def scores (values: []i32): []i32 =
  values
def latest (values: []i32): i32 =
  last values
local def sort [n] (array: [n]i32): []i32 =
  let a = loop a = copy array for i in 1..<n do
    let ai = a[i]
    let (a2, j) = loop (a2, j) = (a, i) while j > 0 && a2[j - 1] < ai do
      (a2 with [j] = a2[j - 1], j - 1)
    in
      a2 with [j] = ai
  in
    a
def personal_best (values: []i32): i32 =
  values
  |> sort
  |> head
def personal_top_three (values: []i32): [3]i32 =
  values
  |> sort
  |> take 3
