def orbital_period (planet: []u8): f64 =
  if planet[3] == 'c' then 0.2408467 else
  match planet[0]
    case 'E' -> 1.0
    case 'J' -> 11.862615
    case 'M' -> 1.8808158
    case 'N' -> 164.79132
    case 'S' -> 29.447498
    case 'U' -> 84.016846
    case 'V' -> 0.61519726
    case _ -> assert false 0

def age (planet: []u8) (seconds: i64): f64 =
  f64.round ((f64.i64 seconds) / (315576.0 * orbital_period planet)) / 100.0