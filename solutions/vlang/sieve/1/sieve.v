module main
fn sieve(limit int) []int {
    mut result := []int{len: 0, cap: limit, init: 0}
    mut composite := []bool{len: limit + 1, cap: limit + 1, init: false}
    if limit < 2 {
        return result
    }
    result << 2
    mut p := 3
    for p <= limit {
        if !composite[p] {
            result << p
            mut m := p * p
            for m <= limit {
                composite[m] = true
                m += p + p
            }
        }
        p += 2
    }
    return result
}