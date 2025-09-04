module main
fn points(ch rune) int {
  return match ch {
    `A`, `E`, `I`, `O`, `U`, `L`, `N`, `R`, `S`, `T` { 1 }
    `D`, `G` { 2 }
    `B`, `C`, `M`, `P` { 3 }
    `F`, `H`, `V`, `W`, `Y` { 4 }
    `K` { 5 }
    `J`, `X` { 8 }
    `Q`, `Z` { 10 }
  	else { 0 }
  }
}
fn score(word string) int {
  mut result := 0
  for ch in word {
    result += points(ch & (~0x20))
  }
  return result
}