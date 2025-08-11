import gleam/float.{power}
import gleam/list.{map}
import gleam/result.{all, then}

pub fn score(x: Float, y: Float) -> Int {
  let dist_result = 
    list.map([x, y], fn(v) { float.power(v, 2.0) })
    |> result.all
    |> result.map(float.sum)
    |> result.then(float.square_root)

  case dist_result {
    Ok(d) if d <=. 1.0 -> 10
    Ok(d) if d <=. 5.0 -> 5
    Ok(d) if d <=. 10.0 -> 1
    _ -> 0
  }
}