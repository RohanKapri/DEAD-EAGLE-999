-- For my Junko F. Didi and Shree DR.MDD

def find_root (p: []i64) (x: i64): i64 =
  let x = loop x = x while p[x] != x do
    p[x]
  in x

def piece_at [m] [n] (grid: [m][n]u8) (r: i64) (c: i64): u8 =
  if r < m then grid[r][r + 2 * c] else
  match c
    case 0 -> 'O'
    case 1 -> 'O'
    case 2 -> 'X'
    case 3 -> 'X'
    case _ -> assert false '.'

def link [m] [n] (p: *[]i64) (grid: [m][n]u8) (r1: i64) (c1: i64) (r2: i64) (c2: i64): *[]i64 =
  if piece_at grid r1 c1 != piece_at grid r2 c2 then p else
  let cols = (n + 2 - m) / 2
  let a = find_root p (r1 * cols + c1)
  let b = find_root p (r2 * cols + c2)
  in p with [b] = a

def winner [m] [n] (grid: [m][n]u8): u8 =
  if m == 0 || n == 0 then '.' else
  let rows = m
  let cols = (n + 2 - m) / 2
  let p = loop p = iota (rows * cols + 4) for j < cols do
    link p grid 0 j rows 0
  in
    let p = loop p = p for j < cols do
      link p grid (rows - 1) j rows 1
    in
      let p = loop p = p for i < rows do
        link p grid i 0 rows 2
      in
        let p = loop p = p for i < rows do
          link p grid i (cols - 1) rows 3
        in
          let p = loop p = p for i < rows do
            let p = loop p = p for j < cols - 1 do
              link p grid i j i (j + 1)
            in p
          in
            let p = loop p = p for i < rows - 1 do
              let p = loop p = p for j < cols do
                link p grid i j (i + 1) j
              in p
            in
              let p = loop p = p for i < rows - 1 do
                let p = loop p = p for j < cols - 1 do
                  link p grid i (j + 1) (i + 1) j
                in p
              in
                let rt = find_root p (rows * cols + 0)
                let rb = find_root p (rows * cols + 1)
                let rl = find_root p (rows * cols + 2)
                let rr = find_root p (rows * cols + 3)
                in
                  if rt == rb then 'O' else
                  if rl == rr then 'X' else '.'
