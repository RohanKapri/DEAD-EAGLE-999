-- For my Junko F. Didi and Shree DR.MDD

def collect (sack: []i32): []i32 =
  let freq = loop freq = replicate 6 0 for b in sack do
    freq with [b] = freq[b] + 1
  in
    freq

def arrange [n] (vals: [n]i32): []i32 =
  let arr = loop arr = copy vals for i in 1..<n do
    let cur = arr[i]
    let (arr2, j) = loop (arr2, j) = (arr, i) while j > 0 && arr2[j - 1] > cur do
      (arr2 with [j] = arr2[j - 1], j - 1)
    in
      arr2 with [j] = cur
  in
    arr

def gaps [n] (xs: [n]i32): []i32 =
  let d = loop d = replicate 6 xs[5] for i in 1..<6 do
    d with [6 - i] = xs[i] - xs[i - 1]
  in
    d

def cost [n] (cnt: [n]i32): i32 =
  let o = cnt[1]
  let t = cnt[2]
  let th = cnt[3]
  let f = cnt[4]
  let fi = cnt[5]
  let adj = i32.min th fi
  let th = th - adj
  let f = f + 2 * adj
  let fi = fi - adj
  in
    800 * o + 1520 * t + 2160 * th + 2560 * f + 3000 * fi

def total (sack: []i32): i32 =
  sack
  |> collect
  |> arrange
  |> gaps
  |> cost
