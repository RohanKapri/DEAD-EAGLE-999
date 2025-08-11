import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  let max_a = sum / 3
  list.range(1, max_a)
  |> list.fold([], fn(triplets, a) {
    let max_b = {sum - a} / 2
    let new_triplets = 
      list.range(a + 1, max_b)
      |> list.fold([], fn(acc, b) {
        let c = sum - a - b
        case c > b && is_pythagorean(a, b, c) {
          True -> [Triplet(a, b, c), ..acc]
          False -> acc
        }
      })
    list.append(triplets, new_triplets)
  })
}

fn is_pythagorean(a: Int, b: Int, c: Int) -> Bool {
  a * a + b * b == c * c
}