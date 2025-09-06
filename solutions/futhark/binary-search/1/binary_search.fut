def find [n] (array: [n]i32) (value: i32): i32 =
  let n = i32.i64 n
  let (low, _) = loop (low, high) = (0, n) while low < high do
    let middle = (low + high) / 2
    in
      if array[middle] < value then (middle + 1, high)
      else (low, middle)
  in
    assert (low < n && array[low] == value) low