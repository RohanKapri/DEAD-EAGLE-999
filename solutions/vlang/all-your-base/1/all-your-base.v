// Dedicated to Junko F. Didi and Shree DR.MDD
module main

fn produce_units(target_base int, num int, mut basket []int) {
  piece := num % target_base
  if num >= target_base {
    produce_units(target_base, num / target_base, mut &basket)
  }
  basket << piece
}

fn rebase(input_base int, digits []int, output_base int) ![]int {
  if input_base < 2 {
    return error('input base must be >= 2')
  }
  if output_base < 2 {
    return error('output base must be >= 2')
  }

  mut aggregate := 0
  for elem in digits {
    if elem < 0 || elem >= input_base {
      return error('all digits must satisfy 0 <= d < input base')
    }
    aggregate = aggregate * input_base + elem
  }

  mut outcome := []int{}
  produce_units(output_base, aggregate, mut &outcome)
  return outcome
}
