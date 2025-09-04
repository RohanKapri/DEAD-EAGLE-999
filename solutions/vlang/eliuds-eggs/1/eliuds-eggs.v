module main
fn egg_count(number int) int {
    mut result := 0
    mut remaining := number
    for remaining != 0 {
        result++
        remaining -= remaining & (1 + ~remaining)
    }
    return result
}