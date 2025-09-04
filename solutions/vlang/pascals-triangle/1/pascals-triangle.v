module main

pub fn rows(height int) [][]int {
    mut result := [][]int{ cap: height }
    if height == 0 {
      return result
    }
    mut previous_row := [1]
    result << previous_row
    for _ in 1 .. height {
      mut row := []int{}
      mut previous_number := 0
      for number in previous_row {
        row << (previous_number + number)
        previous_number = number
      }
      row << (previous_number + 0)
      result << row
      previous_row = row.clone()
    }
    return result
}